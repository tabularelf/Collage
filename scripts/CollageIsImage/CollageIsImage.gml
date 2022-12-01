/// @func CollageIsImage(value)
/// @param {Any} value
/* Feather ignore all */
function CollageIsImage(_image) {
	return (is_struct(_image) && (instanceof(_image) == "__CollageImageClass"));
}