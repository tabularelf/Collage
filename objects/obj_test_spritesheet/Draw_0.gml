var _array = texPage.ImagesToArray(true);
var _info = _array[current_time / 4000 mod array_length(_array)];

CollageDrawImagePart(_info, current_time / 400, 5, 5, 64, 64, 256, 256);