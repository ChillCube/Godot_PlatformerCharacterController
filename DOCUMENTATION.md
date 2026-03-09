# Godot_PlatformerCharacterController API Reference
Generated: 2026-03-09

A simple character controller for platformer games in Godot

### 📦 Dependencies
| Class | Addon | Repository |
| :--- | :--- | :--- |
| [`SmoothMovement`](https://github.com/ChillCube/Godot_SmoothMovement/blob/main/DOCUMENTATION.md#class-smoothmovement) | Godot_SmoothMovement | [Repo](https://github.com/ChillCube/Godot_SmoothMovement) |

---

## Class: PlatformerCharacter
**Inherits:** [`CharacterBody2D`](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)


### Signals
| Signal | Description |
| :--- | :--- |
| **moving** | Emitted when the character is moving and returns the direction and speed of this dash using a Vector2 (length of vector = speed, the vector itself shows the direction) |
| **started_dashing** | Emitted when the character dashes and returns the direction and speed of this dash using a Vector2 (length of vector = speed, the vector itself shows the direction) |
| **used_a_dash** | emitted when the character performs a dash. Returns how many dashes the character has left and what the maximum amount of dashes are. |
| **stopped_dashing** | emitted when the character is finished tashing |
| **jumping** | emitted when the character jumps |
| **moving_down** | emitted when the character is moving down (holding the down button while falling) |
| **moving_left** | emitted when the character walks to the left |
| **moving_right** | emitted when the character walks to the right |
| **touching_floor** | emitted when the character touches the floor |
| **stopped_moving** | emitted when the character is no longer moving |
| **knocked_back** | emitted when the character is being knocked back. It returns the direction and the strength of the knockback as seperate values. |
| **knockback_stopped** | emitted when the character was knocked back and the knockback has stopped |

---

