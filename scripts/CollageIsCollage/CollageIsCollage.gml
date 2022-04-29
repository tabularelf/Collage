/// @func CollageIsCollage(_collage)
/// @param collage
function CollageIsCollage(_collage) {
	return (is_struct(_collage) && (instanceof(_collage) == "Collage"));
}