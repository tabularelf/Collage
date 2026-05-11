function __CollageBboxStore(_bbox) {
	static _list = __CollageBboxStorage();
	array_push(_list, _bbox);
}