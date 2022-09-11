/// @function CollageIsPowerTwo(number)
/// @param number
/* Feather ignore once GM1042 */
function CollageIsPowerTwo(_num) {
	gml_pragma("forceinline");
    return (_num & (_num - 1)) == 0;
}
