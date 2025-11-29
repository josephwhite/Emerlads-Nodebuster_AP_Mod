class_name TrapProcessor
extends Node

var modMain: Node
var isCameraShaking: bool = false
var isCRT: bool = false
var isRigged: bool = false

var waiting_room: Array = []

const traplink_item_mapping: Dictionary = {
    # Nodebuster Traps
    "Camera Shake Trap": "Camera Shake Trap",
    "CRT Trap": "CRT Trap",
    "Rigged Trap": "Rigged Trap",
    # Traps from other games
    # Custom Aliases
    "Casino Trap": "Rigged Trap",
    "The House Always Wins Trap": "Rigged Trap",
}

func _process_trap(trap_name: String) -> void:
    var mapped_trap = ""
    if (traplink_item_mapping.has(trap_name)):
        mapped_trap = traplink_item_mapping[trap_name]
    if mapped_trap == "":
        return
    match mapped_trap:
        "Camera Shake Trap":
            _deploy_camera_shake_trap()
        "CRT Trap":
            _deploy_crt_trap()
        "Rigged Trap":
            _deploy_rigged_trap()
        _:
            return

func _deploy_camera_shake_trap() -> void:  
    isCameraShaking = true
    var temp_screenshake_intensity = Globals.screenshake_intensity
    Globals.screenshake_intensity = 1
    Refs.camera.shake(8, 10, 70)
    Globals.screenshake_intensity = temp_screenshake_intensity
    isCameraShaking = false

func _deploy_crt_trap() -> void:
    if(isCRT == true):
        return
    isCRT = true
    var temp_CRT_option = OptionData.get_option("crt_effect")
    OptionData.apply_option("crt_effect", 0)
    Refs.crt.material.set_shader_parameter("wobble_speed", 15.0)
    Refs.crt.material.set_shader_parameter("wobble_strength", 13.0)
    Refs.crt.material.set_shader_parameter("scanline_count", 600)
    Refs.crt.material.set_shader_parameter("scanline_movespeed", 20)
    Refs.crt.material.set_shader_parameter("chromatic", 20.0)
    Refs.crt.material.set_shader_parameter("ghosting", 3.00)
    Refs.crt.material.set_shader_parameter("bloomRadius", 10.0)
    Refs.crt.material.set_shader_parameter("bloomIntensity", 17.0)
    await MyTimer.wait(10.0)
    _reset_crt_shader_params()
    OptionData.apply_option("crt_effect", temp_CRT_option)
    isCRT = false

func _reset_crt_shader_params() -> void:
    Refs.crt.material.set_shader_parameter("wobble_speed", 0.1)
    Refs.crt.material.set_shader_parameter("wobble_frequency", 0.3)
    Refs.crt.material.set_shader_parameter("wobble_strength", 0.5)
    Refs.crt.material.set_shader_parameter("fisheye", 0.25)
    Refs.crt.material.set_shader_parameter("brighten", 0.65)
    Refs.crt.material.set_shader_parameter("scanline_count", 240)
    Refs.crt.material.set_shader_parameter("scanline_movespeed", 0.5)
    Refs.crt.material.set_shader_parameter("horizontal_scanline_strength", 0.4)
    Refs.crt.material.set_shader_parameter("vertical_scanline_strength", 0.02)
    Refs.crt.material.set_shader_parameter("chromatic", 2.0)
    Refs.crt.material.set_shader_parameter("ghosting", 0.05)
    Refs.crt.material.set_shader_parameter("vignette", 0.05)
    Refs.crt.material.set_shader_parameter("edge_color", Color(0.03, 0.03, 0.03, 1))
    Refs.crt.material.set_shader_parameter("bloomRadius", 1.0)
    Refs.crt.material.set_shader_parameter("bloomThreshold", 1.0)
    Refs.crt.material.set_shader_parameter("bloomIntensity", 1.0)

func _deploy_rigged_trap() -> void:
    if(isRigged == true):
        return
    isRigged = true
    await MyTimer.wait(60.0)
    isRigged = false
