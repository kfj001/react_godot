'use strict';
const express = require('express');

const app = express();
const port = 3001; // The API port

const generateSphere = function () {
    const _rings = 600;
    const _radialSegments = 600;
    const _radius = 1;

    // Vertex indices.
    var thisRow = 0;
    var prevRow = 0;
    var point = 0;

    var verts = [];
    var normals = [];
    var uvs = [];
    var indices = [];

    // Loop over rings.
    for (var i = 0; i < _rings + 1; i++) {
        var v = (i) / _rings;
        var w = Math.sin(Math.PI * v);
        var y = Math.cos(Math.PI * v);

        // Loop over segments in ring.
        for (var j = 0; j < _radialSegments + 1; j++) {
            var u = (j) / _radialSegments;
            var x = Math.sin(u * Math.PI * 2);
            var z = Math.cos(u * Math.PI * 2);
            var vert = [x * _radius * w, y * _radius, z * _radius * w];
            verts.push(vert);
            normals.push(vert);
            uvs.push([u, v]);
            point += 1;

            // Create triangles in ring using indices.
            if (i > 0 && j > 0) {
                indices.push(prevRow + j - 1);
                indices.push(prevRow + j);
                indices.push(thisRow + j - 1);

                indices.push(prevRow + j);
                indices.push(thisRow + j);
                indices.push(thisRow + j - 1);
            }
        }

        prevRow = thisRow;
        thisRow = point;
    }

    return {
        verts: verts,
        normals: normals,
        uvs: uvs,
        indices: indices
    }
};

// API endpoint - This generates a 1 meter primitive and related surface data.
app.get('/api/data', (req, res) => {
    // Define a Sphere
    var geometry = generateSphere();

    // Encode as json string
    var jsonToReturn = JSON.stringify(geometry);

    // Set nice client headers
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Access-Control-Allow-Origin', '*');

    // Godot web client **demands** to know this.
    res.setHeader('Content-Length', jsonToReturn.length);

    // Return the json in the body of the response
    res.write(jsonToReturn);
});

// Start the server
app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});