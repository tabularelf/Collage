// To be added
//var _gpuBlendMode = gpu_get_blendmode_ext_sepalpha();
//gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_inv_src_alpha);

/// @ignore
/// feather ignore all
function __CollageBuilderClass() constructor {
	/// feather ignore all
	owner = other;
	bboxPoints = [];
	init = false;
	freeSpacePoints = [];

	static __RejectionCheck = function(_spriteData, _index) {
		var _texWidth = owner.__width;
		var _texHeight = owner.__height;
		var _crop = owner.__crop;
		var _indexStr = _spriteData.__owner != undefined ? $"- external frame: {sprite_get_number(_spriteData.__spriteID) + _index+1}" : "";

		var _spriteId = _spriteData.__spriteID;
		if (!sprite_exists(_spriteId)) {
			__CollageTrace($"Image \"{_spriteData.__name}{_indexStr}\" contains no sprite data! Skipping...");
			_spriteData.__CleanUp();
			return false;
		}       
           
		var _spriteInfo = sprite_get_info(_spriteId);
		if (_spriteInfo.type != 0) {
			__CollageTrace($"Image \"{_spriteData.__name}{_indexStr}\" contains no bitmap data! Skipping...");
			_spriteData.__CleanUp();
			return false;
		}       

		if (_spriteData.__alpha <= 0.001) {
			__CollageTrace($"Image \"{_spriteData.__name}{_indexStr}\" alpha is too small! Value is at {_spriteData.__alpha}. Skipping...");
			_spriteData.__CleanUp();
			return false;
		}
		        
		var _sprWidth = _spriteInfo.width;
		var _sprHeight = _spriteInfo.height;
		var _drawX, _drawY, _drawW, _drawH;
		var _xScale = 1;
		var _yScale = 1;
		var _forceScaled = false;
		var _tiling = __CollageExtractTiling(_spriteData.__tiling);
		_drawX = ((_crop >= 1) ? ((_crop == 1 || _crop == 2) ? sprite_get_bbox_left(_spriteId) : 0) : 0);
		_drawY = ((_crop >= 1) ? ((_crop == 1 || _crop == 3) ? sprite_get_bbox_top(_spriteId) : 0) : 0);
		_drawW = ((_crop >= 1) ? ((_crop == 1 || _crop == 2) ? sprite_get_bbox_right(_spriteId)-_drawX+1 : _sprWidth) : _sprWidth);
		_drawH = ((_crop >= 1) ? ((_crop == 1 || _crop == 3) ? sprite_get_bbox_bottom(_spriteId)-_drawY+1 : _sprHeight) : _sprHeight);
		var _bbWidth = _drawW;
		var _bbHeight = _drawH;
		var _ratio = 1;
           
		if (_drawW + (_tiling[0] ? 4 : 0) > _texWidth || _drawH + (_tiling[1] ? 4 : 0) > _texHeight) {
			if (!__COLLAGE_SCALE_TO_TEXTURES_ON_PAGE) {
				__CollageTrace($"Image \"{_spriteData.__name}{_indexStr}\" is too big! Skipping...");
				_spriteData.__CleanUp();
				return false;
			} else {
				_xScale = _texWidth/_drawW;
				_yScale = _texHeight/_drawH;
				_ratio = min(_xScale, _yScale);
				_bbWidth = _ratio * _drawW;
				_bbHeight = _ratio * _drawH;
				__CollageTrace(
					$"Image \"{_spriteData.__name}{_indexStr}\" has been rescale from width: {_drawW}" +
					$"height: {_drawH} - to width: {_bbWidth}, height: {_bbHeight}."
				);
			}
		}

		_spriteData.__metadata = {};
		_spriteData.__metadata.drawX = _drawX;
		_spriteData.__metadata.drawY = _drawY;
		_spriteData.__metadata.drawW = _drawW;
		_spriteData.__metadata.drawH = _drawH;
		_spriteData.__metadata.xScale = _xScale;
		_spriteData.__metadata.yScale = _yScale;
		_spriteData.__metadata.ratio = _ratio;
		_spriteData.__metadata.bbWidth = _bbWidth + (_tiling[0] ? 2 : 0);
		_spriteData.__metadata.bbHeight = _bbHeight + (_tiling[1] ? 2 : 0);
		_spriteData.__metadata.wScale = _drawW * _ratio;
		_spriteData.__metadata.hScale = _drawH * _ratio;
		_spriteData.__metadata.hashes = (__COLLAGE_USE_HASHES && owner.GetHashing() ? __CollageHashGenerator(_spriteId) : undefined);
		_spriteData.__metadata.spriteInfo = _spriteInfo;
		_spriteData.__metadata.tiling = _tiling;

		return true;
	};

	static __NameMatch = function(_name, _array, _index = 0) {
		static _ctx = {
			name: ""
		};

		static _callback = method(_ctx, function(_spriteData) {
			return _spriteData.__name = name;
		});

		_ctx.name = _name;
		return array_find_index(_array, _callback, _index);
	}
	
	static __Build = function(_async = false) {
		var _collageName = owner.__GetName();
		var _len = array_length(owner.__batchImageList);
		if (_len == 0) {
			__CollageTrace(_collageName +"Building was commenced but there was no images to pack!");
			return;
		}

		// Store building time for verbose later
		var _startTime = get_timer();
		array_resize(owner.__recent, 0);

		var _texWidth = owner.__width;
		var _texHeight = owner.__height;
		var _spriteList = array_create(array_length(owner.__batchImageList));
		array_copy(_spriteList, 0, owner.__batchImageList, 0, array_length(owner.__batchImageList));
		array_resize(owner.__batchImageList, 0);
		var _sep = owner.__separation;
		var _3dArraySize = 0;
		var _normalArraySize = 0;
		var _rejectedImages = 0;

		var _sterlized = CollageIsGPUStateSterlized();
	
		// Force sterlizing and restoring, in case something was altered.
		if (_sterlized) {
			CollageRestoreGPUState();	
		}

		CollageSterlizeGPUState();

		
		var _oldSize = array_length(_spriteList);
		var _newSize = array_filter_ext(_spriteList, __RejectionCheck);
		array_resize(_spriteList, _newSize);
		var _rejectedImages = _oldSize - _newSize;
		var _totalRejection = _rejectedImages;

		_oldSize = array_length(_spriteList);
		var _i = array_length(_spriteList)-1;
		repeat(array_length(_spriteList)) {
			var _spriteData = _spriteList[_i];
			var _result = __NameMatch(_spriteData.__name, _spriteList);
			if (_result != -1) & (_result != _i) {
				_spriteData.__CleanUp();
				__CollageTrace($"{_collageName} \"{_spriteData.__name}\" has a name conflict with another! Rejecting!");
				array_delete(_spriteList, _i, 1);
			}
			--_i;
		}
		_newSize = array_length(_spriteList);
		_rejectedImages += _oldSize - _newSize;
		_totalRejection += _rejectedImages;
		__CollageTrace($"{_collageName} Early rejection of main sprites: {_rejectedImages}.");

		var _i = 0;
		repeat(array_length(_spriteList)) {
			var _spriteData = _spriteList[_i];
			if (array_length(_spriteData.__externalFrames) > 0) {
				var _externalFrames = _spriteData.__externalFrames;
				_oldSize = array_length(_externalFrames);
				_newSize = array_filter_ext(_externalFrames, __RejectionCheck);
				array_resize(_externalFrames, _newSize);
				_rejectedImages = _oldSize - _newSize;
				_totalRejection += _rejectedImages;
				__CollageTrace($"{_collageName} Early rejection of {_spriteData.__name} external frames: {_rejectedImages}.");
			}
			++_i;
		}

		var _normalSprites = array_filter(_spriteList, function(_spriteClass) {return !_spriteClass.__is3D;});
		var _3dSprites = array_filter(_spriteList, function(_spriteClass) {return _spriteClass.__is3D;});

		_normalArraySize = array_length(_normalSprites);
		_3dArraySize = array_length(_3dSprites);


		if (init == false) {
			array_push(bboxPoints, __CollageBboxRequest(_sep, _sep, _texWidth - _sep, _texHeight - _sep));
			init = true;
		}

		
		var _job = new __CollageBuilderBatchClass(_normalSprites, _3dSprites, self, owner);
		if (!_async) {
			CollageRestoreGPUState();
			CollageSterlizeGPUState();
			_job.__currentTexPage.Start();
			while(!_job.IsFinished()) {
				_job.Next();
			}
			//_job.__currentTexPage.Finish();
			delete _job;

			// Finish
			var _rejectedImgStr = (_totalRejection > 0) ? (" Rejected " +string(_totalRejection) + "!") : "";
			__CollageTrace(_collageName + "Building finished! Packed " + string(_normalArraySize) + " images and " + string(_3dArraySize) + " separate images with separate texture pages." + _rejectedImgStr);
			var _finalTime = (get_timer()-_startTime)/1000;
			__CollageTrace(_collageName + "Total time: " + string(_finalTime) + "ms!");
			CollageRestoreGPUState();
			return;
		}

		return _job;
	};
}