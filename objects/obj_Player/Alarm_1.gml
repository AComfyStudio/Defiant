//Alarm for parry timing

//If a collision is detected from the character. 
if collision_circle(x, y, 16, my_spikemap, true, false) && parry_timer < 60{
		
	canJump = false; 
	can_dash = false;
	alarm[0] = 3;
	show_debug_message("Parried");
	dash_direction = point_direction(0, 0, keyboard_check(ord("D")) - keyboard_check(ord("A")) , keyboard_check(ord("S")) - keyboard_check(ord("W")));
	dash_speed = dash_distance/dash_time;
	dash_energy = dash_distance;
	state = StateParry;
	parry_timer = 0;
}
//When a parry is not met at a certain frame. 
else {
	parry_timer ++;
	//Reset the alarm
	if parry_timer <= 60 {
			alarm[1] = 1;
	} else {
		//Ending the parry window and reseting the parry timer
		alarm[1] = -1;
		parry_timer = 0;
	}
	
	
	

}