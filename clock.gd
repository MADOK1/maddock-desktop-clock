extends Control

@export var HourHand:Node2D
@export var MinuteHand:Node2D

var current_time
var current_hour_in_non_military_time
var current_time_degrees

func _process(delta: float) -> void:
	update_hands()
	
func update_hands():
	current_time = Time.get_datetime_dict_from_system()
	if current_time["hour"] > 12:
		current_time["hour"] -= 12
	var point_to_look_at = get_node("/root/Clock/Clock/Point" + str(current_time["hour"]))
	HourHand.look_at(point_to_look_at.global_position)
	MinuteHand.rotation_degrees = (current_time["minute"]*360)/60
