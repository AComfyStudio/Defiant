//Step event for movement controls
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
space = keyboard_check_pressed(vk_space);
dash = keyboard_check_pressed(vk_shift);
parry = keyboard_check_pressed(ord("K"));

//Runs the code for a state every step
state();

if (place_meeting(x, y, my_spikemap) && can_die == true){
	instance_destroy();
	show_debug_message("Died");
	obj_Respawn.alarm[0] = 30;
}
