/// @func CollageGet(identifier)
/// @param identifier
/* Feather ignore once GM1042 */
function CollageGet(_identifier) {
	gml_pragma("forceinline");
    return global.__CollageTexturePagesMap[$ _identifier];
}
