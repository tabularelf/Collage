/// @function CollageConvertPowerTwo(number)
/// @param number
/* Feather ignore once GM1042 */
function CollageConvertPowerTwo(_num) {
	gml_pragma("forceinline");
	return power(2,round(log2(_num)));	
}
