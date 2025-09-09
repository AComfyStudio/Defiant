///Code for inputs and events applicable to all object states. 
//Step event for movement controls
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
space = keyboard_check_pressed(vk_space);
dash = keyboard_check_pressed(vk_shift);
parry = keyboard_check_pressed(ord("K"));
pause = keyboard_check_pressed(vk_enter);

//Pause button
if pause{
	if !instance_exists(obj_Pause){
		instance_create_depth(0, 0, 0, obj_Pause);
	} else{
		instance_destroy(obj_Pause);
	}
}

//Pause check
if screen_pause() {
	show_debug_message("Freeze");
	exit;

}

//Runs the code for a state every step
state();


//Detecting if the player makes contact with a spike or projectile
if ((place_meeting(x, y, my_spikemap) || place_meeting(x, y, obj_Parry_Object)) && can_die == true){
	instance_destroy();
	show_debug_message("Died");
	obj_Respawn.alarm[0] = 30;
}
