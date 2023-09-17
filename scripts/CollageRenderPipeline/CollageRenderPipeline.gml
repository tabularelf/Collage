/// @func CollageRenderPipeline()
function CollageRenderPipeline(_vertexFormat = undefined, _funcStart = undefined, _funcEnd = undefined) constructor {
	/* feather ignore all*/
	__vbArray = [];
	__status = CollageRPStatus.EMPTY;
	__vFormat = undefined;
	__funcStart = _funcStart;
	__funcEnd = _funcEnd;
	__vertexFunc = _vertexFormat;
	
	static __freezeVB = function(_i) {
		__vbArray[_i].__frozen = true;
		vertex_freeze(__vbArray[_i].__vbuffer);
	}
	
	static __findVB = function(_texID) {
		/* feather ignore all*/
		var _i = 0;
		repeat(array_length(__vbArray)) {
			if (__vbArray[_i].__textureID == _texID) && (!__vbArray[_i].__frozen) && (!__vbArray[_i].__locked) {
				return _i;
			}
			++_i;
		}
		return -1;
	}
	
	static SetVFormat = function(_vFormat) {
		if (__vFormat == _vFormat) return self;
		__vFormat = _vFormat;	
		Clear();
		return self;
	}
	
	static SetDrawFuncs = function(_funcStart, _funcEnd) {
		__funcStart = _funcStart;
		__funcEnd = _funcEnd;
		return self;
	}
	
	static SetVFormatFunc = function(_func) {
		__vertexFunc = _func;	
		return self;
	}
	
	static GetStatus = function() {
		return __status;	
	}
	
	static Start = function() {
		Clear(true);
		var _i = 0;
		__status = CollageRPStatus.BATCHING;
		repeat(array_length(__vbArray)) {
			if (!__vbArray[_i].__locked) __vbArray[_i].Begin(__vFormat);
			++_i;
		}	
		return self;
	}
	
	static StartAppend = function() {
		var _i = 0;
		__status = CollageRPStatus.BATCHING;
		repeat(array_length(__vbArray)) {
			if (!__vbArray[_i].__frozen) && (!__vbArray[_i].__locked) __vbArray[_i].Begin(__vFormat);
			++_i;
		}
		return self;
	}
	
	static AddImage = function(_imageData, _subImage, _x, _y, _z = 0, _width = 1, _height = 1, _angle = 0, _col = draw_get_color(), _alpha = draw_get_alpha(), _respectOrigin = true) {
		var _tex = _imageData.GetTexturePage(_subImage);
		var _index = __findVB(_tex.__textureID);
		if (_index == -1) {
			var _vb = new __CollageVBufferClass(_tex);
			array_push(__vbArray, _vb);
			_index = array_length(__vbArray)-1;
			_vb.Begin(__vFormat);
		}
		__CollageBuildImage(__vbArray[_index].__vbuffer, _imageData, _subImage, _x, _y, _z, _width, _height, _angle, _col, _alpha, _respectOrigin, __vertexFunc);
		return self;
	}
	
	static Finish = function() {
		var _i = 0;
		if (__status != CollageRPStatus.BATCHING) __CollageThrow(".Start() was not called for this CollageRenderPipeline Instance!");
		repeat(array_length(__vbArray)) {
			if (!__vbArray[_i].__frozen) && (!__vbArray[_i].__locked) __vbArray[_i].End();
			++_i;
		}		
		__status = CollageRPStatus.BATCHED;
		return self;
	}
	
	static Draw = function() {
		var _len = array_length(__vbArray);
		if (_len == 0) exit;
		
		var _i = 0;
		if (__funcStart != undefined) __funcStart();
		repeat(_len) {
			if (!__vbArray[_i].__texturePage.__isLoaded) __vbArray[_i].__texturePage.CheckSurface();
			vertex_submit(__vbArray[_i].__vbuffer, pr_trianglelist, __vbArray[_i].__texturePage.GetTexture());
			++_i;
		}	
		if (__funcEnd != undefined) __funcEnd();
	}
	
	static Lock = function() {
		var _i = 0;
		repeat(array_length(__vbArray)) {
			__vbArray[_i].Lock();	
			++_i;
		}
		return self;
	}
	
	static Unlock = function() {
		var _i = 0;
		repeat(array_length(__vbArray)) {
			__vbArray[_i].Unlock();	
			++_i;
		}
		return self;
	}
	
	static Freeze = function() {
		var _i = 0;
		repeat(array_length(__vbArray)) { 
			if (!__vbArray[_i].__frozen) {
				__freezeVB(_i);
			}
			++_i;
		}	
		return self;
	}
	
	static Clear = function(_frozenOnly = false) {
		var _i = 0;
		if (_frozenOnly) {
			repeat(array_length(__vbArray)) {
				if (__vbArray[_i].__frozen) {
					__vbArray[_i].Destroy();
					__vbArray[_i].__vbuffer = -1;
					array_delete(__vbArray, _i, 1);
					--_i;
				}
				++_i;
			}
		} else {
			repeat(array_length(__vbArray)) {
				__vbArray[_i].Destroy();
				++_i;
			}
			array_resize(__vbArray, 0);
			__status = CollageRPStatus.EMPTY;
		 }
		 return self;
	}
	
	static GetBatchCount = function() {
		return array_length(__vbArray);	
	}
}