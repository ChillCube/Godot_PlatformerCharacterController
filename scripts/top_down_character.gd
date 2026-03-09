extends CharacterBody2D
class_name PlatformerCharacter

signal moving(direction_and_speed : Vector2) ## Emitted when the character is moving and returns the direction and speed of this dash using a Vector2 (length of vector = speed, the vector itself shows the direction)
signal started_dashing(direction_and_speed : Vector2) ## Emitted when the character dashes and returns the direction and speed of this dash using a Vector2 (length of vector = speed, the vector itself shows the direction)
signal used_a_dash(dashes_left : int, dashes_used : int, max_dashes : int) ## emitted when the character performs a dash. Returns how many dashes the character has left and what the maximum amount of dashes are. 
signal stopped_dashing ## emitted when the character is finished tashing

signal jumping ## emitted when the character jumps
signal moving_down ## emitted when the character is moving down (holding the down button while falling)
signal moving_left ## emitted when the character walks to the left
signal moving_right ## emitted when the character walks to the right

signal touching_floor ## emitted when the character touches the floor
signal stopped_moving ## emitted when the character is no longer moving

signal knocked_back(direction : Vector2 , strength : float) ## emitted when the character is being knocked back. It returns the direction and the strength of the knockback as seperate values. 
signal knockback_stopped ## emitted when the character was knocked back and the knockback has stopped

@export var speed : float = 200; ## defines the speed of the character
@export var down_speed : float = 500; ## definens how quickly the character falls when the player holds the down button
@export_range(0, 1) var acceleration : float = 1; ## how quickly the character goes from 0 to max speed
@export_range(0, 1) var deceleration : float = 0.1 ## how quickly the character goes from max speed to 0
@export var gravity : float = 300 ## how strong gravity is

@export_group("Jumping")
@export var max_jumps : int = 1; ## how often the character can jump
var jumps_used : int = 0; ## how many jumps the character has used
@export var jump_strength : float = 5.5; ## sets the jump strength
@export var koyote_time : float = 0.3; ## if the player jumps slightly after leaving a platform, the jump should still count. This value adjusts how strict it should be. A high value will be less strict and a low value will be stricter. 0 will disable it.
var koyote_timer : SceneTreeTimer = null; 

@export_group("Dash")
@export var enable_dashing : bool = true; ## sets whether the character should be able to dash or not
@export var dash_speed : float = 5; ## sets how fast the dash should be
@export var dash_time : float = 0.5; ## sets how long the dash should be
@export_range(0, 1) var dash_falloff : float = 0.3 ## how quickly the dash goes from 1 to 0;
@export var dash_timeout : float = 0.5; ## how long after performing one dash until you are allowed to perform another
@export var dashes : int = 1; ## how many dashes the character is allowed to do at once
var dashes_used : int = 0; ## how many dashes the character has used
var dash_vector : Vector2 = Vector2.ZERO ## the direction and speed of the dash
@onready var dash_timer : SceneTreeTimer = get_tree().create_timer(0); ## the timer that is used to keep track of the length of a dash
@onready var dash_timeout_timer : SceneTreeTimer = get_tree().create_timer(0); ## the timer that is used to keep track of timeout time in between dashes

@export_group("Knockback")
@export var enable_knockback : bool = true; #if set to true will enable knockback
@export var knockback_speed : float = 5; ## determines how fast the knockback will be
@export var knockback_time : float = 0.5; ## determines how long the knockback will be
@export_range(0, 1) var knockback_falloff : float = 0.3 ## determines how quickly the knockback goes from full speed to nothing
var knockback_vector : Vector2 = Vector2.ZERO ## shows the direction and speed of the knockback
@onready var knockback_timer : SceneTreeTimer = get_tree().create_timer(0); ## the timer that is used to keep track of the length of the knockback

@export_category("Controls")
@export var input_dash : String = "dash" ## the input that is used to perform a dash

@export_group("Keyboard")
@export var input_left : String = "ui_left" ## the input that is used to move left
@export var input_right : String = "ui_right" ## the input that is used to move right
@export var input_down : String = "ui_down" ## the input that is used to move down
@export var input_jump : String = "ui_up" ## the input that is used to jump

@export_group("Controller")
@export var deadzone : float = 0.1 ## the deadzone on the controller (to prevent stick drift)

var acceleration_vector : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var max_speed = speed
	
	#region GET DIRECTIONAL INPUTS

	var input_vector : Vector2 = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength(input_right) - Input.get_action_strength(input_left)
	
	var joy_stick_strength : Vector2 = Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X), Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))
	if joy_stick_strength.length() > deadzone:
		input_vector = Vector2(joy_stick_strength.x, 0);

	input_vector = input_vector.normalized()

#endregion
	
	#region DASH
	if enable_dashing:
		if Input.is_action_just_pressed(input_dash):
			if dash_timeout_timer.time_left < 0.1:
				dashes_used = 0;
			if dashes_used < dashes:
				emit_signal("started_dashing", input_vector)
				emit_signal("used_a_dash", dashes - dashes_used, dashes_used, dashes)
				dash_vector = (input_vector * dash_speed *200);
				dash_timer = get_tree().create_timer(dash_time)
				dash_timeout_timer = get_tree().create_timer(dash_timeout)
				dashes_used += 1;
		if dash_timer.time_left < 0.01:
			dash_vector += (Vector2(0,0) - dash_vector) * dash_falloff
			if dash_vector.length() < 1:
				emit_signal("stopped_dashing")

	#endregion
	
	var max_speed_vector = input_vector * max_speed 
	var deceleration_vector = (Vector2.ZERO - Vector2(velocity.x, 0)) * deceleration
	var acceleration_vector : Vector2 = Vector2(0,0);
	if input_vector.x > 0:
		acceleration_vector.x = ((max_speed_vector.x - velocity.x) * acceleration) + (input_vector.x * deceleration_vector.length())
	elif input_vector.x < 0:
		acceleration_vector.x = ((max_speed_vector.x - velocity.x) * acceleration) + (input_vector.x * deceleration_vector.length())
	else:
		acceleration_vector = Vector2.ZERO
		if velocity.length() < max_speed * 0.1:
			emit_signal("stopped_moving")
	velocity += (acceleration_vector + deceleration_vector) * delta * 10;
	velocity.y += gravity * delta
	if Input.is_action_just_pressed(input_down):
		velocity.y += down_speed * delta * 100;
	var can_jump : bool = false;
	
	# Check if jumping is possible (with koyote time)
	if is_on_floor():
		emit_signal("touching_floor")
		jumps_used = 0;
		can_jump = true;
	else:
		#check for koyote time
		if koyote_timer == null:
			koyote_timer = get_tree().create_timer(koyote_time);
			koyote_timer.connect("timeout", _on_koyote_timeout)
		else:
			can_jump = true;
	# Check for jumping input
	if can_jump and Input.is_action_just_pressed(input_jump) and jumps_used < max_jumps:
		emit_signal("jumping")
		jumps_used += 1;
		velocity.y -= jump_strength *100 * delta
	velocity += dash_vector + knockback_vector * delta
	if velocity.length() > 0.1:
		emit_signal("moving", velocity)
	
	move_and_slide()
	emit_direction()

func _on_koyote_timeout() -> void:
	koyote_timer = null;

## Used to start knockback
func knockback(direction: Vector2, strength : float) -> void:
	emit_signal("knocked_back", direction, strength)
	if enable_knockback:
		knockback_vector = (direction.normalized() * knockback_speed * 200 * strength);
		knockback_timer = get_tree().create_timer(knockback_time)
	if knockback_timer.time_left < 0.01:
		knockback_vector += (Vector2(0,0) - knockback_vector) * knockback_falloff
		if knockback_vector.length() < 0.1:
			emit_signal("knockback_stopped")


func emit_direction() -> void:
	if velocity.length() == 0:
		return

	var angle = velocity.angle()
	
	if angle >= -PI/4 and angle < PI/4:
		emit_signal("moving_right")
	elif angle >= PI/4 and angle < 3 * PI/4:
		emit_signal("moving_down")
	elif angle >= 3 * PI/4 or angle < -3 * PI/4:
		emit_signal("moving_left")
	else: # angle >= -3 * PI/4 and angle < -PI/4
		emit_signal("moving_up")
