// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Decelerates an object 
function decelerate(spd, spd_var, multiplier){
	spd = spd - (0.3 * spd_var * multiplier);
	return spd;
}