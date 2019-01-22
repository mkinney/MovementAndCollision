/// @description Move
// If we press a button, we move the player

input_left = keyboard_check(vk_left);
input_right = keyboard_check(vk_right);
input_up = keyboard_check(vk_up);
input_down = keyboard_check(vk_down);


moveX = 0;
moveY = 0;
moveX = (input_right - input_left) * player_speed;

// only move one way at a time (no diagonals)
if (moveX == 0) {
	moveY = (input_down - input_up) * player_speed;
}


// collision checks with wall
// horizontal
if (moveX != 0) {
	// Note: It is subtle, but the obj_wall below means all
	// "instances" of obj_wall.
	if (place_meeting(x + moveX, y, obj_wall)) {
		repeat (abs(moveX)) {
			if (! place_meeting(x + sign(moveX), y, obj_wall)) {
				x += sign(moveX);
			} else {
				break;
			}
		}
		moveX = 0;
	}
}

// vertical
if (moveY != 0) {
	if (place_meeting(x, y + moveY, obj_wall)) {
		repeat (abs(moveY)) {
			if (! place_meeting(x, y + sign(moveY), obj_wall)) {
				y += sign(moveY);
			} else {
				break;
			}
		}
		moveY = 0;
	}
}


// apply movement ensuring we cannot move out of the room
var tmp_x = x + moveX
var tmp_y = y + moveY

// Note: This assumes "middle center" for obj_player's sprite
if ((tmp_x - (sprite_width / 2) >= 0) && (tmp_x <= window_get_width() - (sprite_width / 2))) {
	x += moveX
}
if ((tmp_y - (sprite_height / 2) >= 0) && (tmp_y <= window_get_height() - (sprite_height / 2))) {
	y += moveY
}