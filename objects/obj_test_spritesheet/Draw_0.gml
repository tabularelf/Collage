var _array = texPage.ImagesToArray(true);
var _info = _array[current_time / 4000 mod array_length(_array)];

CollageDrawImageExt(_info, current_time / 400, 256, 256, 16, 16, current_time/10, c_white, 1);