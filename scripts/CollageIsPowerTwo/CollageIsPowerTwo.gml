/// @function CollageIsPowerTwo
/// @param real
function CollageIsPowerTwo(_num) {
	gml_pragma("forceinline");
    return (_num & (_num - 1)) == 0;
}
