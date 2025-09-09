///Define Player variables and stats
//Speed and gravity applied on the player
hsp = 0;
vsp = 0;
grv = 0.3;

//Variables affecting dash and parry
can_die = true;
can_dash = false;
dash_distance = 96;
dash_direction = 0;
dash_time = 10;
parry_timer = 0;
dtimer = 1;

//Variables affecting jump
canJump = true;


//Set the tilemaps to variables
my_tilemap = layer_tilemap_get_id("Tiles_1");
my_spikemap = layer_tilemap_get_id("Tiles_2")



//Default state
StateFree = function()
{





//Facing directions 
var facing = keyboard_check(ord("D")) - keyboard_check(ord("A"));//Determine the direction the player is facing
var verfacing = keyboard_check(ord("S")) - keyboard_check(ord("W"));//Determine whether the player is holding up or down.

//Setting horizontal and vertical speed 
if (place_meeting(x, y + 2, my_tilemap)) || (hsp <= 3 && hsp >= -3){
	hsp = facing * walk_speed;
	dtimer = 1;
}
if vsp < 10{
	vsp = vsp + grv;
} 


//Jump input
if space && canJump{
	show_debug_message("Jump");
	vsp = -jump;
	canJump = false; 


}

//Dash input 
if can_dash && dash {
	can_dash = false;
	canJump = false; 
	dash_direction = point_direction(0, 0, facing, verfacing);
	dash_speed = dash_distance/dash_time;
	dash_energy = dash_distance;
	state = StateDash;
}
	
//Parry input
if parry{
	alarm[1] = 1;
	
	
}

//Horizontal collision and movement
if (place_meeting(x + hsp, y, my_tilemap)){
	while (abs(hsp) > 0.1) {
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, my_tilemap)) x += hsp;
	}
	hsp = 0;
}
if hsp > 3 {
	hsp = decelerate(hsp, dtimer, 1);
	dtimer ++;
} else if hsp < -3 {
	hsp = decelerate(hsp, dtimer, -1);
}
x += hsp;

//Vertical collision and movement. 
if (place_meeting(x, y + vsp + 1, my_tilemap)){
	if vsp > 0 {
		canJump = true;
		can_dash = true;
		if (hsp != 0){
			sprite_index = (spr_Player_run);
		} else {
			sprite_index = spr_Player;
		}

	}
	
	while (abs(vsp) > 0.1) {
		vsp *= 0.5; 
		if (!place_meeting(x, y + vsp, my_tilemap)) y += vsp;
	}
	vsp = 0;
	
} else if vsp > 0 {
	sprite_index = spr_Player;
} else if sprite_index != spr_Player_jump{
	image_index = 0;
	sprite_index = spr_Player_jump;
}
if vsp <= -7{
	dtimer = 5;
	vsp = decelerate(vsp, dtimer, -1);
}
y += vsp;


if (hsp != 0) image_xscale = sign(hsp);



}
//Dashing state. 
StateDash = function() 
{
	
//Speed of the dash. 
	
hsp = lengthdir_x(dash_speed, dash_direction);
vsp = lengthdir_y(dash_speed, dash_direction);
	
//Horizontal collision and movement
if (place_meeting(x + hsp, y, my_tilemap)){
	while (abs(hsp) > 0.1) {
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, my_tilemap)) x += hsp;
	}
	hsp = 0;
}

x += hsp;


//Vertical collision and movement. 
if (place_meeting(x, y + vsp, my_tilemap)){
	//Slow down the character gradually
	while (abs(vsp) > 0.1) {
		vsp *= 0.5; 
		//If there is no longer a wall, add the reduced speed
		if (!place_meeting(x, y + vsp, my_tilemap)) y += vsp;
	}
	vsp = 0;
	
}

y += vsp;

	
	
//Ending the dash
dash_energy -= dash_speed;
if dash_energy <= 0{
	if vsp < 0{
		vsp = -3;
	}
	state = StateFree;

}


	
}

//Parry state
StateParry = function() 
{

//Parry movement
hsp = lengthdir_x(dash_speed, dash_direction) * 1.13;
vsp = lengthdir_y(dash_speed, dash_direction) * 1.13;
	
//Canceling into another parry.
/*if parry {
	show_debug_message("Parry attempt 2")
	alarm[1] = 1;
}*/
//Horizontal collision and movement
if (place_meeting(x + hsp, y, my_tilemap)){
	while (abs(hsp) > 0.1) {
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, my_tilemap)) x += hsp;
	}
	hsp = 0;
}

x += hsp;

//Vertical collision and movement. 
if (place_meeting(x, y + vsp, my_tilemap)){
	
	while (abs(vsp) > 0.1) {
		vsp *= 0.5; 
		if (!place_meeting(x, y + vsp, my_tilemap)) y += vsp;
	}
	vsp = 0;
	
}
y += vsp;

//Ending the state
dash_energy -= dash_speed 
if dash_energy <= 0{
	if vsp < 0{
		vsp = -5;
	}
	state = StateFree;
}

}

//Sets the state. 
state = StateFree;