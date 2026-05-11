/// @ignore
/// feather ignore all
function __CollageExtractTiling(_tiling) {
	gml_pragma("forceinline");
	static _tilingResult = [0, 0];
	_tilingResult[0] = _tiling >> 8; 
	_tilingResult[1] = _tiling & 0x1;
	return _tilingResult;
}