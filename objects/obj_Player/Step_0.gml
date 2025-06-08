//Step event for movement controls

//Set keyboard variables for convenience
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));
var up = keyboard_check(ord("W"))
var down = keyboard_check(ord("S"));
var space = keyboard_check(vk_space);
var dash = keyboard_check_pressed(vk_shift);
var parry = keyboard_check_pressed(ord("K"));


var collision_found = collision_circle(x, y, 20, my_spikemap, true, false);
var overspeed_collision = collision_circle(x, y, 16, my_tilemap, true, false);

var facing = right - left;//Determine the direction the player is facing
var verfacing = down - up;//Determine whether the player is holding up or down.

var hspd = 0; 
var vspd = 0; 

dash_duration = max(dash_duration - 1, 0);//Reduces the dash duration every frame until it hits 0. 
if dash_duration == 0 {//Once the dash is over the player recovers their ability to dash. 
	not_dashing = true;
} 

if overspeed_collision && dash_duration < 0{
	move_x = 0;
	move_y = 0;
}

if not_dashing == true{ //Checks if the player is not dashing to avoid reseting the dash speed every frame. 
	move_x = facing * walk_speed;
}



if(place_meeting(x, y + 2, my_tilemap)){//Checks if the player is colliding with the tilemap. 
	move_y = 0;
	if has_dash == false has_dash = true;//Resets the dash once landing on the ground. 
	
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
	hspd = facing * 10; 
	vspd = verfacing * 20;
	if (right - left != 0 && down - up != 0){ //Checks for diagonal movement input, both keys must have some input.  
		move_x = 0.707 * facing * 10;//Multiply by 0.707 to make speed consistent with horizontal dashes
		move_y = 0.707 * verfacing * 10;//Same as above. 
	} else {
		move_x = facing * 10;
		move_y = verfacing * 10;
	}
}

if (place_meeting(x, y, my_spikemap) && can_die == true){
	instance_destroy();
	show_debug_message("Died");
	obj_Respawn.alarm[0] = 30;
}

if parry {
	for (var i = 0; i < 60; i += 1){
		show_debug_message(string(i) + "frame")
		if collision_found{
			can_die = false;
			alarm[0] = 15;
			not_dashing = false;
			dash_duration = 30
			show_debug_message("Parried")
			hspd = facing * 10; 
			vspd = verfacing * 20; 
			if (right - left != 0 && down - up != 0){ 
				move_x = 0.707 * facing * 15;
				move_y = 0.707 * verfacing * 15;
				break;
			} else {
				move_x = facing * 15;
				move_y = verfacing * 15;
				break;
			}
	
	
		}
	}
	
}
	


move_and_collide(move_x, move_y, my_tilemap);//Establishes the collision with the tilemap. 


if (move_x != 0) image_xscale = sign(facing);
//Flips the direction the player is facing when moving in different directions. 