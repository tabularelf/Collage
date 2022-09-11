/// @func CollageGetImageInfo(identifier)
/// @param {String} identifier
/* Feather ignore once GM1042 */
function CollageGetImageInfo(_identifier) {
	gml_pragma("forceinline");
	if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
		__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
	}
	return global.__CollageImageMap[$ _identifier];
}
