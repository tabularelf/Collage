/// @func CollageIsImage(image)
/// @param {Struct.__CollageImageClass} image
/* Feather ignore once GM1042 */
function CollageIsImage(_image) {
	return (is_struct(_image) && (instanceof(_image) == "__CollageImageClass"));
}