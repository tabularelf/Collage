/// @func image_get_uvs(sprite_index/image, image_index)
/// @param {Any} sprite_index/image
/// @param {Real} image_index
/* Feather ignore once GM1042 */
function image_get_uvs(_sprite, _sub) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		if (sprite_exists(_sprite)) {
			return sprite_get_uvs(_sprite, _sub);
		}
	} else {
		/* Feather ignore once GM1035 */
		return CollageCompatibilityGetImageUVs(_sprite, _sub);
	} 
} 
