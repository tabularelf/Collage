/// @func CollageImageAsync()
/* Feather ignore all */
function CollageImageAsync() {
	gml_pragma("forceinline");
    var _fileName = async_load[? "filename"];
    var _id = async_load[? "id"];
    var _status = async_load[? "status"];
    
    var _i = 0;
    repeat(array_length(global.__CollageAsyncList)) {
        var _asyncList = global.__CollageAsyncList[_i].__asyncList;
        var _j = 0;
        repeat(array_length(_asyncList)) {
            if (_id == _asyncList[_j][0].__spriteID) {
                if (_status >= 0) && (sprite_get_number(_asyncList[_j][0].__spriteID) > 0) {
                    if (!is_undefined(_asyncList[_j][1])) {
						with(global.__CollageAsyncList[_i]) {
							if (__COLLAGE_VERBOSE) __CollageTrace("Running asynchronous callback on " + _asyncList[_j][0].__name + "!");
							script_execute_ext(_asyncList[_j][1], _asyncList[_j][2]);	
						}
					} else {
						if (__COLLAGE_VERBOSE) __CollageTrace("Async: Pushing " + _asyncList[_j][0].__name + " straight to batchlist!");
						array_push(global.__CollageAsyncList[_i].__batchImageList, _asyncList[_j][0]);	
					}
					__CollageTrace(global.__CollageAsyncList[_i].__getName() + _asyncList[_j][0].__name + " loaded from the internet (" + _fileName + ")!");
                } else {
                    __CollageTrace(global.__CollageAsyncList[_i].__getName() + _asyncList[_j][0].__name + " failed to load from (" + _fileName + ")! Error status: " + string(_status));
                }
                array_delete(_asyncList, _j, 1);
                
                if (array_length(_asyncList) == 0) {
                    var _texPage = global.__CollageAsyncList[_i];
                    _texPage.__isWaitingOnAsync = false;
					_texPage.__status = CollageStatus.READY;
                    if (_texPage.__state == CollageBuildStates.NORMAL) {
						_texPage.__builder.__build();
					}
                    array_delete(global.__CollageAsyncList, _i, 1);
                    --_i;
                }
                
                break;
            }
            ++_j;
        }
        ++_i;
    }
}