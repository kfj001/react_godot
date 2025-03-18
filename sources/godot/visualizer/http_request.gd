extends HTTPRequest

@export var target_mesh:CSVMesh

func _ready() -> void:
	# Perform a GET request. The URL below returns JSON as of writing.
	var error = request("http://localhost:3001/api/data")
	if error != OK:
		push_error("An error occurred in the HTTP request.")	

func _on_done(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var remoteObj = JSON.parse_string(body.get_string_from_utf8())
	target_mesh.create_polygon_from_csv(remoteObj)
