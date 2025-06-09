//Define Player variables and stats

hsp = 0;//Horizontal speed of the player. 
vsp = 0;//Vertical speed of the player. 
grv = 0.5;//Gravity applied on the player. 

can_die = true;
can_dash = false;
dash_distance = 96;
dash_time = 10;


canJump = true;

parry_timer = 0;


my_tilemap = layer_tilemap_get_id("Tiles_1");
my_spikemap = layer_tilemap_get_id("Tiles_2")



//Default state
StateFree = function()
{





//Facing directions. 
var facing = keyboard_check(ord("D")) - keyboard_check(ord("A"));//Determine the direction the player is facing
var verfacing = keyboard_check(ord("S")) - keyboard_check(ord("W"));//Determine whether the player is holding up or down.

//Setting horizontal and vertical speed. 
hsp = facing * walk_speed;

vsp = vsp + grv;

	
if space && canJump{ //Detects the input to jump
	show_debug_message("Jump");
	vsp = -jump;
	canJump = false; 
}

//Dash input. 
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

x += hsp;

//Vertical collision and movement. 
if (place_meeting(x, y + vsp, my_tilemap)){
	if vsp > 0 {
		canJump = true;
		can_dash = true;
	}
	
	while (abs(vsp) > 0.1) {
		vsp *= 0.5; 
		if (!place_meeting(x, y + vsp, my_tilemap)) y += vsp;
	}
	vsp = 0;
	
}


y += vsp;



//Touching a spike. 


	




if (hsp != 0) image_xscale = sign(facing);
//Flips the direction the player is facing when moving in different directions. 
//Maps the tilemap to a variable for future reference. 
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
	
	while (abs(vsp) > 0.1) {
		vsp *= 0.5; 
		if (!place_meeting(x, y + vsp, my_tilemap)) y += vsp;
	}
	vsp = 0;
	
}
y += vsp;
	
	
	
	dash_energy -= dash_speed;
	if dash_energy <= 0{
		vsp = 0;
		hsp = 0;
		state = StateFree;
	}


	
}

StateParry = function() 
{
	
//Parry movement
hsp = lengthdir_x(dash_speed, dash_direction) * 1.2;
vsp = lengthdir_y(dash_speed, dash_direction) * 1.2;
	
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
	vsp = 0;
	hsp = 0;
	state = StateFree;
}

}

//Sets the state. 


state = StateFree;