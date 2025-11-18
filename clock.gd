extends Control

@export var HourHand:Node2D
@export var MinuteHand:Node2D

var current_time
var current_hour_in_non_military_time
var current_time_degrees

var past_hour_for_speaking = 0
var past_quarter_for_speaking = 0

#var Hour_Recordings = {"1": }

func _process(delta: float) -> void:
	update_hands()
	speak_time()
func update_hands():
	current_time = Time.get_datetime_dict_from_system()
	if current_time["hour"] > 12:
		current_time["hour"] -= 12
	var point_to_look_at = get_node("/root/Clock/Clock/Point" + str(current_time["hour"]))
	HourHand.look_at(point_to_look_at.global_position)
	MinuteHand.rotation_degrees = (current_time["minute"]*360)/60

func speak_time():
	current_time = Time.get_datetime_dict_from_system()
	if current_time["hour"] > 12:
		current_time["hour"] -= 12
	
	#if current_time["hour"] != past_hour_for_speaking:
		
	#past_hour_for_speaking = current_time["hour"]
	#past_quarter_for_speaking = current_time[""]
# _on_audio_stream_player_2d_finished() -> void:
	
