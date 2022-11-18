/// @function CollageIsPowerTwo(number)
/// @param number
/// Feather ignore all
function CollageIsPowerTwo(_num) {
	gml_pragma("forceinline");
    return (_num & (_num - 1)) == 0;
}
