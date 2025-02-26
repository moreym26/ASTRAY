extends Node2D

signal done

var messages = []

var typing_speed = .05
var read_time = 1.5

var current_message = 0
var display = ""
var current_char = 0


func _ready():
	visible = false
	
func start_dialogue(dialogue):
	stop_dialogue()
	visible = true
	messages = dialogue
	current_message = 0
	display = ""
	current_char = 0
	
	$NextChar.set_wait_time(typing_speed)
	$NextChar.start()

func stop_dialogue():
	display = ""
	$Label.text = display
	$NextChar.stop()
	$NextMessage.stop()
	visible = false

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		$NextChar.stop()
		$NextMessage.one_shot = true
		$NextMessage.set_wait_time(read_time)
		$NextMessage.start()

func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$NextChar.start()
