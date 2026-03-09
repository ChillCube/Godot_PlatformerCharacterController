# Godot_PlatformerCharacterController API Reference
Generated on: 2026-03-09

A simple character controller for platformer games in Godot

---

## Class: PlatformerCharacter
### Properties
| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **speed** | `float` | `200;` | defines the speed of the character |
| **down_speed** | `float` | `500;` | definens how quickly the character falls when the player holds the down button |
| **acceleration** | `float` | `1;` | how quickly the character goes from 0 to max speed |
| **deceleration** | `float` | `0.1` | how quickly the character goes from max speed to 0 |
| **gravity** | `float` | `300` | how strong gravity is |
| **max_jumps** | `int` | `1;` | how often the character can jump |
| **jumps_used** | `int` | `0;` | how many jumps the character has used |
| **jump_strength** | `float` | `5.5;` | sets the jump strength |
| **koyote_time** | `float` | `0.3;` | if the player jumps slightly after leaving a platform, the jump should still count. This value adjusts how strict it should be. A high value will be less strict and a low value will be stricter. 0 will disable it. |
| **enable_dashing** | `bool` | `true;` | sets whether the character should be able to dash or not |
| **dash_speed** | `float` | `5;` | sets how fast the dash should be |
| **dash_time** | `float` | `0.5;` | sets how long the dash should be |
| **dash_falloff** | `float` | `0.3` | how quickly the dash goes from 1 to 0; |
| **dash_timeout** | `float` | `0.5;` | how long after performing one dash until you are allowed to perform another |
| **dashes** | `int` | `1;` | how many dashes the character is allowed to do at once |
| **dashes_used** | `int` | `0;` | how many dashes the character has used |
| **dash_vector** | `Vector2` | `Vector2.ZERO` | the direction and speed of the dash |
| **knockback_speed** | `float` | `5;` | determines how fast the knockback will be |
| **knockback_time** | `float` | `0.5;` | determines how long the knockback will be |
| **knockback_falloff** | `float` | `0.3` | determines how quickly the knockback goes from full speed to nothing |
| **knockback_vector** | `Vector2` | `Vector2.ZERO` | shows the direction and speed of the knockback |
| **input_dash** | `String` | `"dash"` | the input that is used to perform a dash |
| **input_left** | `String` | `"ui_left"` | the input that is used to move left |
| **input_right** | `String` | `"ui_right"` | the input that is used to move right |
| **input_down** | `String` | `"ui_down"` | the input that is used to move down |
| **input_jump** | `String` | `"ui_up"` | the input that is used to jump |
| **deadzone** | `float` | `0.1` | the deadzone on the controller (to prevent stick drift) |

---
