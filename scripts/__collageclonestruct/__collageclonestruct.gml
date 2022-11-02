function __CollageCloneStruct(_struct) {
	var _newStruct = {};
	var _keys = variable_struct_get_names(_struct);
	var _i = 0;
	repeat(array_length(_keys)) {
		_newStruct[$ _keys[_i]] = _struct[$ _keys[_i]];
		++_i;
	}
	return _newStruct;
}