var _size = 256;
var _finalSize = keyboard_check(vk_space) ? abs(sin(current_time / 1000))*_size : _size;

draw_image_stretched(texPage.GetImageInfo("spr_tiletest"), 0, 128, 128, _finalSize, _finalSize);
draw_image_stretched(texPage.GetImageInfo("spr_soldier"), current_time/100, 128, 128, _finalSize, _finalSize);
