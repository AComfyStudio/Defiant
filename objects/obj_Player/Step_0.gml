//Step event for movement controls

//Set keyboard variables for convenience
var left = keyboard_check(vk_left);
var right = keyboard_check(vk_right);
var up = keyboard_check(vk_up)
var down = keyboard_check(vk_down);
var space = keyboard_check(vk_space);
var dash = keyboard_check_pressed(vk_shift);


var facing = right - left;//Determine the direction the player is facing
var verfacing = down - up;//Determine whether the player is holding up or down.

dash_duration = max(dash_duration - 1, 0);//Reduces the dash duration every frame until it hits 0. 
if dash_duration == 0 {//Once the dash is over the player recovers their ability to dash. 
	not_dashing = true;
}

if not_dashing == true{ //Checks if the player is not dashing to avoid reseting the dash speed every frame. 
	move_x = facing * walk_speed;
}


if(place_meeting(x, y + 2, my_tilemap)){//Checks if the player is colliding with the tilemap. 
	move_y = 0;
	if has_dash == false has_dash = true;
	
	if space{ //Detects the input to jump
		move_y = -jump;
	}
}else if (place_meeting(x, y - 2, my_tilemap)){//Checks if the player is jumping into a ceiling, then applies gravity.
	move_y = 0;
	if move_y < 10 {
		move_y += 0.5;
	}
	
} else { //Applies gravity constantly for a smooth falling. 
	if move_y < 10 {
		move_y += 0.5;
	}
}

if dash && has_dash = true{ //Checks if the player has a dash and if they input a dash. 
	dash_duration = 10;
	not_dashing = false;
	has_dash = false;
	if (right - left != 0 && down - up != 0){ //Checks for diagonal movement input, both keys must have some input.  
		move_x = 0.707 * (facing * 10);
		move_y = 0.707 * (verfacing * 10); 
	}
}




move_and_collide(move_x, move_y, my_tilemap);

if (move_x != 0) image_xscale = sign(facing);
//Flips the direction the player is facing when moving in different directions. 