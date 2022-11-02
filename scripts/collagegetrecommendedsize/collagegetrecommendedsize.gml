function CollageGetRecommendedSize(_array) {
	gml_pragma("forceinline");
	var _maxSize = -infinity;
	var _i = 0;
	repeat(array_length(_array)) {
		var _w = sprite_get_width(_array[_i]);
		var _h = sprite_get_height(_array[_i]);
		
		if (_w > _maxSize) || (_h > _maxSize) {
			_maxSize = _w > _h ? _w : _h;
		}
		++_i;
	}
	
	return CollageConvertPowerTwo(clamp(_maxSize, __COLLAGE_MIN_TEXTURE_SIZE, __COLLAGE_MAX_TEXTURE_SIZE));
}