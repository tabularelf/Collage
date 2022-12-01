/// @func CollageIsCollage(value)
/// @param {Any} value
/* Feather ignore all */
function CollageIsCollage(_collage) {
	return (is_struct(_collage) && (instanceof(_collage) == "Collage"));
}