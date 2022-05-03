/// @func CollageGet(identifier)
/// @param identifier
function CollageGet(_identifier) {
	gml_pragma("forceinline");
    return global.__CollageTexturePagesMap[$ _identifier];
}
