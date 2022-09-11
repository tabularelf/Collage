/// @func CollageDestroy(identifier)
/// @param identifier
/* Feather ignore once GM1042 */
function CollageDestroy(_identifier) {
	gml_pragma("forceinline");
    if (is_string(_identifier)) {
		global.__CollageTexturePagesMap[$ _identifier].Destroy();
    }
    
    _identifier.Destroy();
}