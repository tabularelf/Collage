/// @func CollageDestroy(identifier)
/// @param identifier
function CollageDestroy(_identifier) {
	gml_pragma("forceinline");
    if (is_string(_identifier)) {
		global.__CollageTexturePagesMap[$ _identifier].Destroy();
    }
    
    _identifier.Destroy();
}