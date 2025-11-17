class_name TrapProcessor
extends Node

var modMain: Node
var isCameraShaking: bool = false
var isRigged: bool = false

func _deploy_camera_shake_trap() -> void:  
    isCameraShaking = true
    var temp_screenshake_intensity = Globals.screenshake_intensity
    Globals.screenshake_intensity = 1
    Refs.camera.shake(8, 10, 70)
    Globals.screenshake_intensity = temp_screenshake_intensity
    isCameraShaking = false


func _deploy_rigged_trap() -> void:
    if(isRigged == true):
        return
    isRigged = true
    isRigged = false