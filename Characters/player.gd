extends CharacterBody2D

@export var move_speed : int = 100
@export var starting_direction : Vector2 = Vector2(1,0)

# parameters/Idle/blend_position
# testing a github by commenting

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

func _ready():
	update_animation_parameters(starting_direction)
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action() 
			return 
			
	
# I added normalized in the direction because if theres none, diagonal movement will be faster than 1d movement
func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	# print(input_direction)
	update_animation_parameters(input_direction)
	velocity = (input_direction * move_speed)
	
	move_and_slide()
	
	pick_new_state()
	
func update_animation_parameters(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
