var _x = mouse_x;
var _y = mouse_y;

if (texPage.exists("spr_soldier")) {
	draw_image_general(texPage.getImageInfo("spr_soldier"), current_time/1000, 0, 0, _x, _y, 8, 8, 1, 1, 0, c_white, c_green, c_red, c_blue, 1);
}

draw_image_general(spr_soldier, current_time/1000, 0, 0, _x, _y, 8, 128, 1, 1, 0, c_white, c_green, c_red, c_blue, 1);
