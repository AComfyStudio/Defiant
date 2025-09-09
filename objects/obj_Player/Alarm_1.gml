//Alarm for parry timing

//If a collision is detected from the character. 
if (collision_circle(x, y, 24, my_spikemap, true, false)||collision_circle(x, y, 24, obj_Parry_Object, true, false) ) && parry_timer < 60{
	canJump = false; 
	can_die = false;
	alarm[0] = 20;
	alarm[2] = 14;
	show_debug_message("Parried");
	dash_speed = dash_distance/dash_time;
	dash_energy = dash_distance;
	if state != StateParry(){
		state = StateParry;
	}
	parry_timer = 0;
	instance_create_depth(0, 0, 0, obj_Pause_Short);
}
//When a parry is not met at a certain frame. 
else {
	parry_timer ++;
	show_debug_message(parry_timer);
	//Reset the alarm
	if parry_timer <= 50 {
			alarm[1] = 1;
	} else {
		//Ending the parry window and reseting the parry timer
		alarm[1] = -1;
		parry_timer = 0;
	}
	
	
	

}