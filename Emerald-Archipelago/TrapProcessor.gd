class_name TrapProcessor
extends Node

var modMain: Node

var isCameraShaking: bool = false
var isCRT: bool = false
var isGlitched: bool = false
var isRigged: bool = false
var isStunlocked: bool = false

# Traps waiting to activate
var waiting_room: Array = []

var last_mouse_pos: Vector2 = Vector2(0, 0)

const traplink_item_mapping: Dictionary = {
    # Nodebuster Traps
    "Camera Shake Trap": "Camera Shake Trap",
    "CRT Trap": "CRT Trap",
    "Glitch Trap": "Glitch Trap",
    "Rigged Trap": "Rigged Trap",
    "Stunlock Trap": "Stunlock Trap",
    # Traps from other games
    "Chaos Control Trap": "Stunlock Trap",
    # Custom Aliases
    "Casino Trap": "Rigged Trap",
    "The House Always Wins Trap": "Rigged Trap",
    "Stun Lock Trap": "Stunlock Trap",
}


# Main entrypoint for calling traps from traplink and item recieve
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
        "Glitch Trap":
            _deploy_glitch_trap()
        "Rigged Trap":
            _deploy_rigged_trap()
        "Stunlock Trap":
            _deploy_stunlock_trap()
        _:
            return


# Check waiting room for specified trap, and process it if found
func _poll_waiting_room_for_trap(trap_name: String) -> void:
    #for i in waiting_room:
    #    modMain.apClient.sendChatMessage(str(i))
    if waiting_room.has(trap_name):
        var nextTrap = waiting_room.find(trap_name)
        #modMain.apClient.sendChatMessage("%s found at index %s" % [trap_name, nextTrap])
        waiting_room.remove_at(nextTrap)
        _process_trap(trap_name)
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
        waiting_room.append("CRT Trap")
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
    await MyTimer.wait(30.0)
    _reset_crt_shader_params()
    OptionData.apply_option("crt_effect", temp_CRT_option)
    isCRT = false
    _poll_waiting_room_for_trap("CRT Trap")


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


func _deploy_glitch_trap() -> void:
    if(isGlitched == true):
        waiting_room.append("Glitch Trap")
        return
    isGlitched = true
    Refs.glitch.material.set_shader_parameter("shake_power", 0.03)
    Refs.glitch.material.set_shader_parameter("shake_rate", 1.0)
    Refs.glitch.material.set_shader_parameter("shake_speed", 6.0)
    Refs.glitch.material.set_shader_parameter("shake_block_size", 200.0)
    Refs.glitch.material.set_shader_parameter("shake_color_rate", 0.025)
    Refs.glitch.show()
    await MyTimer.wait(10.0)
    _reset_glitch_shader_params()
    Refs.glitch.hide()
    isGlitched = false
    _poll_waiting_room_for_trap("Glitch Trap")


func _reset_glitch_shader_params() -> void:
    Refs.glitch.material.set_shader_parameter("shake_power", 0.03)
    Refs.glitch.material.set_shader_parameter("shake_rate", 1.0)
    Refs.glitch.material.set_shader_parameter("shake_speed", 5.0)
    Refs.glitch.material.set_shader_parameter("shake_block_size", 240.0)
    Refs.glitch.material.set_shader_parameter("shake_color_rate", 0.01)


func _deploy_rigged_trap() -> void:
    if(isRigged == true):
        waiting_room.append("Rigged Trap")
        return
    isRigged = true
    # TODO: Get snapshot of state
    # TODO: Set all chance stats to 0
    await MyTimer.wait(60.0)
    # TODO: Restore state to snapshot
    isRigged = false
    _poll_waiting_room_for_trap("Rigged Trap")


func _deploy_stunlock_trap() -> void:
    if(isStunlocked == true):
        waiting_room.append("Stunlock Trap")
        return
    isStunlocked = true
    last_mouse_pos = Refs.main_scn.get_viewport().get_mouse_position()
    # TODO: Warp mouse to lock_pose on every frame (or every 0.0001 seconds to replicate staying place)
    # Idea: Connect frame data to warp (not working)
    # Some where between 0.01670-0.016725 seonds
    #var _t_stunlock = MyTimer.create_repeating(0.016725, 1, 250)
    #_t_stunlock.repeated.connect(_warp_mouse_to_last_pos)
    var temp_mouse_mode = Input.get_mouse_mode()
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    Effects.floating_text("STUNLOCK", last_mouse_pos, MyColors.YELLOW)
    await MyTimer.wait(5.0)
    # Remove lock for mouse
    # Idea: Connect frame data to warp (not working)
    Input.set_mouse_mode(temp_mouse_mode)
    isStunlocked = false
    _poll_waiting_room_for_trap("Stunlock Trap")

func _warp_mouse_to_last_pos() -> void:
    Refs.main_scn.get_viewport().warp_mouse(last_mouse_pos)
