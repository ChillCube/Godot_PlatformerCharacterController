# Godot_PlatformerCharacterController API Reference
Generated: 2026-03-09

A simple character controller for platformer games in Godot

### 📦 Dependencies

| Source | Reference | Repository |
| :--- | :--- | :--- |

---

## Class: PlatformerCharacter
**Inherits:** [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)


### ⚙️ Inspector Variables (Exported)
| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **speed** | `float` | `200` | defines the speed of the character |
| **down_speed** | `float` | `500` | definens how quickly the character falls when the player holds the down button |
| **acceleration** | `float` | `1` | how quickly the character goes from 0 to max speed |
| **deceleration** | `float` | `0.1` | how quickly the character goes from max speed to 0 |
| **gravity** | `float` | `300` | how strong gravity is |
| **max_jumps** | `int` | `1` | how often the character can jump |
| **jump_strength** | `float` | `5.5` | sets the jump strength |
| **koyote_time** | `float` | `0.3` | if the player jumps slightly after leaving a platform, the jump should still count. This value adjusts how strict it should be. A high value will be less strict and a low value will be stricter. 0 will disable it. |
| **enable_dashing** | `bool` | `true` | sets whether the character should be able to dash or not |
| **dash_speed** | `float` | `5` | sets how fast the dash should be |
| **dash_time** | `float` | `0.5` | sets how long the dash should be |
| **dash_falloff** | `float` | `0.3` | how quickly the dash goes from 1 to 0; |
| **dash_timeout** | `float` | `0.5` | how long after performing one dash until you are allowed to perform another |
| **dashes** | `int` | `1` | how many dashes the character is allowed to do at once |
| **knockback_speed** | `float` | `5` | determines how fast the knockback will be |
| **knockback_time** | `float` | `0.5` | determines how long the knockback will be |
| **knockback_falloff** | `float` | `0.3` | determines how quickly the knockback goes from full speed to nothing |
| **input_dash** | `String` | `"dash"` | the input that is used to perform a dash |
| **input_left** | `String` | `"ui_left"` | the input that is used to move left |
| **input_right** | `String` | `"ui_right"` | the input that is used to move right |
| **input_down** | `String` | `"ui_down"` | the input that is used to move down |
| **input_jump** | `String` | `"ui_up"` | the input that is used to jump |
| **deadzone** | `float` | `0.1` | the deadzone on the controller (to prevent stick drift) |

### 💾 Class Variables (Standard)
| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **jumps_used** | `int` | `0` | how many jumps the character has used |
| **dashes_used** | `int` | `0` | how many dashes the character has used |
| **dash_vector** | `Vector2` | `Vector2.ZERO` | the direction and speed of the dash |
| **dash_timer** | `SceneTreeTimer` | `get_tree().create_timer(0)` | the timer that is used to keep track of the length of a dash |
| **dash_timeout_timer** | `SceneTreeTimer` | `get_tree().create_timer(0)` | the timer that is used to keep track of timeout time in between dashes |
| **knockback_vector** | `Vector2` | `Vector2.ZERO` | shows the direction and speed of the knockback |
| **knockback_timer** | `SceneTreeTimer` | `get_tree().create_timer(0)` | the timer that is used to keep track of the length of the knockback |

### 🔔 Signals
| Signal | Arguments | Description |
| :--- | :--- | :--- |
| **moving** | `direction_and_speed : Vector2` |  Emitted when the character is moving and returns the direction and speed of this dash using a Vector2 (length of vector = speed, the vector itself shows the direction) |
| **started_dashing** | `direction_and_speed : Vector2` |  Emitted when the character dashes and returns the direction and speed of this dash using a Vector2 (length of vector = speed, the vector itself shows the direction) |
| **used_a_dash** | `dashes_left : int`<br>`dashes_used : int`<br>`max_dashes : int` |  emitted when the character performs a dash. Returns how many dashes the character has left and what the maximum amount of dashes are.  |
| **stopped_dashing** | - |  emitted when the character is finished tashing |
| **jumping** | - |  emitted when the character jumps |
| **moving_down** | - |  emitted when the character is moving down (holding the down button while falling) |
| **moving_left** | - |  emitted when the character walks to the left |
| **moving_right** | - |  emitted when the character walks to the right |
| **touching_floor** | - |  emitted when the character touches the floor |
| **stopped_moving** | - |  emitted when the character is no longer moving |
| **knocked_back** | `direction : Vector2 `<br>`strength : float` |  emitted when the character is being knocked back. It returns the direction and the strength of the knockback as seperate values.  |
| **knockback_stopped** | - |  emitted when the character was knocked back and the knockback has stopped |

---

