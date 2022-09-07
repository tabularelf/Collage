/// @func CollageGetImageInfo(identifier)
/// @param identifier
function CollageGetImageInfo(_identifier) {
	gml_pragma("forceinline");
	if (!COLLAGE_IMAGES_ARE_PUBLIC) {
		__CollageThrow("COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
	}
	return global.__CollageImageMap[$ _identifier];
}
