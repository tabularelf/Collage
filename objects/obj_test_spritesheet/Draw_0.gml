var _array = texPage.ImagesToArray(true);
var _info = _array[current_time / 4000 mod array_length(_array)];

draw_image_ext(_info, current_time / 400, 256, 256, 16, 16, 0, c_white, 1);