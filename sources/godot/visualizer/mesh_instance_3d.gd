class_name CSVMesh extends MeshInstance3D		

# Function to parse CSV points and create a polygon and paint it green.
func create_polygon_from_csv(data):
	var polygon_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	
	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indices = PackedInt32Array()	
	
	for datapoint in data.verts:
		verts.append(Vector3(datapoint[0],datapoint[1],datapoint[2]))
	for datapoint in data.uvs:
		uvs.append(Vector2(datapoint[0],datapoint[1]))
	for datapoint in data.normals:
		normals.append(Vector3(datapoint[0],datapoint[1],datapoint[2]))
	for datapoint in data.indices:
		indices.append(datapoint)
	
	arrays[Mesh.ARRAY_VERTEX] = verts
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	
	polygon_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, arrays)
	
	# Because it will blend in with the gray backdrop if we don't...
	var green_material = StandardMaterial3D.new()
	green_material.albedo_color=Color.GREEN
	polygon_mesh.surface_set_material(0,green_material)
	
	
	mesh=polygon_mesh
