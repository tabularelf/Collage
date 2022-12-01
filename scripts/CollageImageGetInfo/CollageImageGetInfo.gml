/// @func CollageImageGetInfo(collage_image_name)
/// @param {String} collage_image_name
/// @return {Struct.__CollageImageClass}
/* Feather ignore all */
function CollageImageGetInfo(_identifier) {
	gml_pragma("forceinline");
	if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
		__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
	}
	
	if (!variable_struct_exists(global.__CollageImageMap, _identifier)) {
		__CollageThrow("Image " + string(_identifier) + " does not exist!");
	}
	
	return global.__CollageImageMap[$ _identifier];
}
