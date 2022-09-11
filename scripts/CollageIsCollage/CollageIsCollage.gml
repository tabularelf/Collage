/// @func CollageIsCollage(collage)
/// @param collage
/* Feather ignore once GM1042 */
function CollageIsCollage(_collage) {
	return (is_struct(_collage) && (instanceof(_collage) == "Collage"));
}