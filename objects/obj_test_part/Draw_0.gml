var _mouse = abs(sin(current_time / 1000))*256;

draw_image_part(texPage.GetImageInfo("spr_soldier"), current_time/100, 0, 0, _mouse, _mouse, 8, 8);
draw_image_part_ext(texPage.GetImageInfo("spr_soldier"), current_time/100, 0, 0, _mouse, _mouse, 8, 64, mouse_x div 32, mouse_y div 32, c_white, 1);
draw_image_part(spr_soldier, current_time/100, 0, 0, _mouse, _mouse, 8, 128);