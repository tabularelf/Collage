/// @func CollageIsImage(image)
/// @param image
function CollageIsImage(_image) {
	return (is_struct(_image) && (instanceof(_image) == "__CollageImageInfo"));
}