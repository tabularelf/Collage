function __CollageBboxRequest(_left, _top, _right, _bottom) {
	static _list  = __CollageBboxStorage();
	var _bbox = array_pop(_list);
	if (is_undefined(_bbox)) {
		_bbox = new __CollageBBoxClass(_left, _top, _right, _bottom)
	} else {
		_bbox.left = round(_left);
		_bbox.top = round(_top);
		_bbox.right = round(_right);
		_bbox.bottom = round(_bottom);
	}
	return _bbox;
}