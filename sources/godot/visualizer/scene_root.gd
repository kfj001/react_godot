extends Node3D

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	var mesh = $MeshInstance3D.mesh
	if mesh is TextMesh:
		var tm:TextMesh = mesh
		tm.text = str(  $HTTPRequest.get_downloaded_bytes()/1024)+" kb"
	else:
		$Timer.stop()
