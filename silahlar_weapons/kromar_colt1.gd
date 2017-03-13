extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)


func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT and event.pressed and not event.is_echo():
			get_node("anim").play("ates_normal")
		if event.button_index == BUTTON_RIGHT and event.pressed and not event.is_echo():
			get_node("anim").play("ates_yavas")