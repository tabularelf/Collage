/// @func CollageIsImage(image)
/// @param image
/* Feather ignore once GM1042 */
function CollageIsImage(_image) {
	return (is_struct(_image) && (instanceof(_image) == "__CollageImageClass"));
}