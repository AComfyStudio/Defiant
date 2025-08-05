//Destroy pause menu if death and pause menu trigger on the same frame.

if instance_exists(obj_Pause){
	instance_destroy(obj_Pause);
}