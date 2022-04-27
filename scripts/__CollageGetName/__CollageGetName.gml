function __CollageGetName(_string) {
	if (__CollageFileFromWeb(_string)) {
		var _stringStartPos = string_last_pos("/", _string)+1;
		var _stringEndPos = string_last_pos(".", _string);
		return string_copy(_string, _stringStartPos, _stringEndPos-_stringStartPos);
	} 
	
	var _stringStartPos = string_last_pos("\\", _string)+1;
	var _stringEndPos = string_last_pos(".", _string);
	return string_copy(_string, _stringStartPos, _stringEndPos-_stringStartPos);
}