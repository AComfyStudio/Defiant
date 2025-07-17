/// @description Insert description here
// You can write your code in this editor
view_enabled = true;
view_visible[0] = true;

//Setting camera size and variables
camera_set_view_size(view_camera[0], 640, 360);
camera_set_view_pos(view_camera[0], 0, 0);

//Internal resolution
surface_resize(application_surface, room_width/2, room_height/2);