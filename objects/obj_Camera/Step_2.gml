/// @description Insert description here
// You can write your code in this editor


var width = camera_get_view_width(view_camera[0]);
var height = camera_get_view_height(view_camera[0]);

if (instance_exists(obj_Player) == true){
	var camerax = obj_Player.x - (width * 0.5);
	var cameray = obj_Player.y - (height * 0.5);
	camera_set_view_pos(view_camera[0], camerax, cameray);
}