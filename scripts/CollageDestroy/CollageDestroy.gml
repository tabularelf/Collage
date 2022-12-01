/// @func CollageDestroy(collage_instance_or_name)
/// @param {Any} collage_instance_or_name
/* Feather ignore all */
function CollageDestroy(_identifier) {
	gml_pragma("forceinline");
    if (is_string(_identifier)) {
		global.__CollageTexturePagesMap[$ _identifier].Destroy();
    } else {
		_identifier.Destroy();	
	}
}