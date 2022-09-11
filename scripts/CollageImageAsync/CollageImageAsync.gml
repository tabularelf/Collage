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
            if (_id == _asyncList[_j].spriteID) {
                if (_status >= 0) && (sprite_get_number(_asyncList[_j].spriteID) > 0) {
                    array_push(global.__CollageAsyncList[_i].__batchImageList, _asyncList[_j]);
					__CollageTrace(global.__CollageAsyncList[_i].__getName() + _asyncList[_j].name + " loaded from the internet (" + string (_fileName) + ")!");
                } else {
                    __CollageTrace(global.__CollageAsyncList[_i].__getName() + _asyncList[_j].name + " failed to load from (" + string (_fileName) + ")! Error status: " + string(_status));
                }
                array_delete(_asyncList, _j, 1);
                
                if (array_length(_asyncList) == 0) {
                    var _texPage = global.__CollageAsyncList[_i];
                    _texPage.__isWaitingOnAsync = false;
					_texPage.__status = CollageStatus.READY;
                    if (_texPage.__state == __CollageStates.NORMAL) {
						var _builder = _texPage[$ "builder"];
						_builder.__build();
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