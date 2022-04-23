/// @function CollageIsPowerTwo
/// @param bool
function CollageIsPowerTwo(_num) {
	gml_pragma("forceinline");
    return (_num & (_num - 1)) == 0;
}
