extends Control

@export var HourHand:Node2D
@export var MinuteHand:Node2D
@export var AudioPlayer:AudioStreamPlayer2D

var current_time
var current_hour_in_non_military_time
var current_time_degrees

var next_hour_for_speaking = 0
var next_quarter_for_speaking = 0
var has_spoken_this_milestone = false
var part_of_time_to_say = "hour"
var hour_voice_file = ""
var minute_voice_file = ""


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
	
	if current_time["minute"] == 15 or current_time["minute"] == 30 or current_time["minute"] == 45 or current_time["minute"] == 0:
		if has_spoken_this_milestone == false:
			$"Body/MouthOpenTimer".start()
			hour_voice_file = load("res://TimeRecordings/" + str(current_time["hour"]) + ".ogg")
			minute_voice_file = load("res://TimeRecordings/" + str(current_time["minute"]) + ".ogg")
			part_of_time_to_say = "intro"
			AudioPlayer.stream = load("res://TimeRecordings/it is currently.ogg")
			AudioPlayer.play()
			has_spoken_this_milestone = true
	else:
		has_spoken_this_milestone = false
func _on_audio_stream_player_2d_finished() -> void:
	if part_of_time_to_say == "intro":
		part_of_time_to_say = "hour"
		AudioPlayer.stream = hour_voice_file
		AudioPlayer.play()
	elif part_of_time_to_say == "hour":
		AudioPlayer.stream = minute_voice_file
		AudioPlayer.play()
		part_of_time_to_say = "minute"
		
func _on_mouth_open_timer_timeout() -> void:
	if $'Body'.texture == load("res://Image.png"):
		$'Body'.texture = load("res://Image2.png")
	else:
		$'Body'.texture = load("res://Image.png")
