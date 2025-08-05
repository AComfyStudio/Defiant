// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function screen_pause(){
	//Detect pause object
	if instance_exists(obj_Pause){
		image_speed = 0;
		return true;
	} else {
		image_speed = 1;
		return false;
	}

}