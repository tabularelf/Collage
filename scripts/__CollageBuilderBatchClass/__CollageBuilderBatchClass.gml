function __CollageBuilderBatchClass(_normalSprites, _3dSprites, _builder, _owner) constructor {
	static __system = __CollageSystem();

	Next = __NormalSpriteTick;
	__frames = 0;
	__isFinished = false;
	__normalSprites = _normalSprites;
	__3dSprites = _3dSprites;
	__total = array_length(__normalSprites) + array_length(__3dSprites);
	__normalSize = array_length(__normalSprites);
	__normalIndex = 0;
	__3dSize = array_length(__3dSprites);
	__3dIndex = 0;
	__owner = _owner;
	__builder = _builder;
	__bboxPoints = __builder.bboxPoints;
	__hashData = (__COLLAGE_USE_HASHES && _owner.GetHashing()) ? __CollageHashData() : undefined;
	__currentTexPage = array_length(__owner.__texPageArray) == 0 ? 
				__GenerateTexturePage() : 
				__owner.__texPageArray[array_length(__owner.__texPageArray)-1];


	__smallestImageWidth = infinity;
	__smallestImageHeight = infinity;
	__crop = __owner.__crop;
	__optimize = __owner.__optimize;
	__batchMode = (__owner.__state == CollageBuildStates.BATCHING);
	__sep = __owner.__separation;

	if ((__batchMode) && (__optimize)) {
		var _i = 0;
		repeat(array_length(__normalSprites)) {
			if (__normalSprites[_i].__metadata.bbWidth < __smallestImageWidth) || (__normalSprites[_i].__metadata.bbHeight < __smallestImageHeight) {
				__smallestImageWidth = __normalSprites[_i].__metadata.bbWidth;
				__smallestImageHeight = __normalSprites[_i].__metadata.bbHeight;
			}
			++_i;
		}
	}

	if (array_length(__normalSprites) > 1) {
		array_sort(__normalSprites, __BboxSort);
	}

	static IsFinished = function() {
		return __isFinished;
	};

	static GetProgress = function() {
		return ((__3dIndex + __normalIndex) / __total) * 100;
	};

	static Tick = function() {
		__frames++;
		__currentTexPage.Start();	
		var _t = get_timer();
		var _targetTime = (_t/1000)+500;
		while(get_timer() / 1000 < _t) {
			Next();
			if (__isFinished) {
				break;
			};
		}
		__currentTexPage.Finish();	
	};
       
	static __NormalSpriteTick = function() {
			var _spriteData = __normalSprites[__normalIndex];     
			__ProcessSprite(_spriteData);

		__normalIndex++;
		if (__normalIndex >= __normalSize) {
			if (__3dSize > 0) {
				Next = __3dSpriteTick;
			} else {
				Next = __End;
			}
		}
	};
       
	static __3dSpriteTick = function() {
		var _spriteData = __3dSprites[__3dIndex];
		__ProcessSprite(_spriteData);

		__3dIndex++;
		if (__3dIndex >= __3dSize) {
			Next = __End;
		}
	};

	static __End = function() {
		if (__isFinished) return;
		__isFinished = true;
		__currentTexPage.Finish();
		array_foreach(__normalSprites, function(_spriteData) {
			_spriteData.__CleanUp();
		});
		array_foreach(__3dSprites, function(_spriteData) {
			_spriteData.__CleanUp();
		});
		
		if (__frames > 0) __CollageTrace($"{__owner.__GetName()} Total frames to execute batch job: {__frames}");
	};

	static __GenerateTexturePage = function(_width = __owner.GetWidth(), _height = __owner.GetHeight()) {
		var _texPage = new __CollageTexturePageClass(_width, _height);
		array_push(__owner.__texPageArray, _texPage);
		__owner.__texPageCount++;
		return _texPage;
	};

	static __CheckImage = function(_name) {
		/* Feather ignore once GM2047 */
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			return variable_struct_exists(__system.__CollageImageMap, _name);	
		} else {
			return variable_struct_exists(__owner.__imageMap, _name);	
		}
	};
	
	static __GetImage = function(_name) {
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			return __system.__CollageImageMap[$ _name];	
		} else {
			return __owner.__imageMap[$ _name];	
		}
	};
	
	static __SetImage = function(_name, _data) {
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			__system.__CollageImageMap[$ _name] = _data;	
		} 

		__owner.__imageMap[$ _name] = _data;	
		array_push(__owner.__imageList, _data);
		array_push(__owner.__recent, _data);
		__owner.__imageCount++;
	};

	static __HashCompare = function(_hashA, _hashB) {
		var _hashLengthB = array_length(_hashB);
		
		if (array_length(_hashA) != _hashLengthB) return false;
		var _i = 0;
		repeat(array_length(_hashA)) {
			if (_i >= _hashLengthB) return false;
			if (_hashA[_i] == _hashB[_i]) {
				return true;
			}
			++_i;
		}
		return false;
	};

	static __BboxSort = function(_elm1, _elm2) {	
		if (_elm1.__priority >= 0) || (_elm2.__priority >= 0) {
			return sign(_elm2.__priority - _elm1.__priority);
		}
		
		var _sizeA, _sizeB;
		_sizeA = ((_elm2.__metadata.bbWidth + (_elm2.__metadata.tiling[0] ? 2 : 0)) + (_elm2.__metadata.bbHeight + (_elm2.__metadata.tiling[1] ? 2 : 0))) * .5; 
		_sizeB = ((_elm1.__metadata.bbWidth + (_elm1.__metadata.tiling[0] ? 2 : 0)) + (_elm1.__metadata.bbHeight + (_elm1.__metadata.tiling[1] ? 2 : 0))) * .5;
		return  (_sizeA - _sizeB);
	};

	static __DrawImage = function(_spriteData, _spriteID, _sub, _drawXValue, _drawYValue, _drawWValue, _drawHValue, _currentPoint = undefined, _ratio = 1, _wScale = 1, _hScale = 1) {
		// Check Premultiply properties
		if (_spriteData.__premultiplyAlpha) {
			var _gpuBlendEnable = gpu_get_blendenable();	
			var _gpuBlendMode = gpu_get_blendmode_ext();
			gpu_set_blendenable(true);
			gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			shader_set(__ShdCollagePremultiply);
		}
		
		static __defaultCP = {
			left: 0,
			top: 0
		}
        
		
		var _point = _currentPoint ?? __defaultCP;
		
		var _tiling = __CollageExtractTiling(_spriteData.__tiling);
		
		var _drawX = (_tiling[0]) ? _drawXValue+2 : _drawXValue;
		var _drawW = (_tiling[0]) ? _drawWValue-2 : _drawWValue;
		var _drawY = (_tiling[1]) ? _drawYValue+2 : _drawYValue;
		var _drawH = (_tiling[1]) ? _drawHValue-2 : _drawHValue;
		var _width = sprite_get_width(_spriteID);
		var _height = sprite_get_height(_spriteID);
		var _col = _spriteData.__colour;
		var _alpha = _spriteData.__alpha;
		
		draw_sprite_part_ext(
			_spriteID, 
			_sub, 
			_drawXValue, 
			_drawYValue, 
			_drawWValue, 
			_drawHValue, 
			_point.left + ((_tiling[0]) ? 2 : 0), 
			_point.top + ((_tiling[1]) ? 2 : 0), 
			_ratio, 
			_ratio, 
			_col, 
			_alpha
		);
		
		#region Tiling
		// Horizontal Tiling
		if (_tiling[0]) {
			// Left
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawW, 
				_drawYValue, 
				2, 
				_drawHValue, 
				_point.left, 
				_point.top + ((_tiling[1]) ? 2 : 0), 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
			// Right
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawX-2, 
				_drawYValue, 
				2, 
				_drawHValue, 
				_point.left + _width + 2, 
				_point.top + ((_tiling[1]) ? 2 : 0), 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
		}
		
		// Vertical Tiling
		if (_tiling[1]) {
			// Top
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawXValue, 
				_drawH, 
				_drawWValue, 
				2, 
				_point.left + ((_tiling[0]) ? 2 : 0), 
				_point.top, 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
			// Bottom
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawXValue, 
				_drawYValue, 
				_drawWValue, 
				2, 
				_point.left + ((_tiling[0]) ? 2 : 0), 
				_point.top + _height + 2, 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
		}
		
		// Horizontal + Vertical Tiling
		if (_tiling[0] && _tiling[1]) {
			// Left Top Corner
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawW,
				_drawH,
				2,
				2,
				_point.left, 
				_point.top, 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
			
			// Right Top Corner
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawXValue,
				_drawH,
				2,
				2,
				_point.left + _width + 2, 
				_point.top, 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
			
			// Left Bottom Corner
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawW,
				_drawYValue,
				2,
				2,
				_point.left, 
				_point.top + _height + 2, 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
			
			// Right Bottom Corner
			draw_sprite_part_ext(
				_spriteID, 
				_sub, 
				_drawXValue,
				_drawYValue,
				2,
				2,
				_point.left + _width + 2, 
				_point.top + _height + 2, 
				_ratio, 
				_ratio, 
				_col, 
				_alpha
			);
		}
		#endregion
		
		if (_spriteData.__premultiplyAlpha) {
			gpu_set_blendenable(_gpuBlendEnable);	
			gpu_set_blendmode_ext(_gpuBlendMode);
			shader_reset();
		}
		
		if (__COLLAGE_RENDER_DEBUG_LINES) {
			draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
			draw_rectangle(_point.left+1,_point.top+1,_point.left+_wScale-2,_point.top+_hScale-2, true);
			draw_set_colour(c_white);	
		}	
	}

	static __ProcessSprite = function(_spriteData, _useBboxPoints = true) {
		var _spriteID = _spriteData.__spriteID;
		var _spriteInfo = _spriteData.__metadata.spriteInfo;
		var _sprWidth = _spriteData.__width;
		var _sprHeight = _spriteData.__height;
		var _metadata = _spriteData.__metadata;	

		var _drawX = _metadata.drawX, _drawY = _metadata.drawY, _drawW = _metadata.drawW, _drawH = _metadata.drawH;
		var _xScale = _metadata.xScale;
		var _yScale = _metadata.yScale;
		var _wScale = _metadata.wScale;
		var _hScale = _metadata.hScale;
		var _ogW = _sprWidth;
		var _ogH = _sprHeight;
		var _xOffset = _spriteData.__xOrigin;
		var _yOffset = _spriteData.__yOrigin;
		var _subImages = _spriteInfo.num_subimages;
		var _hashes = _metadata.hashes;
		
		var _ratio = _metadata.ratio;
		var _tiling = _metadata.tiling;
		var _bbWidth = _metadata.bbWidth;
		var _bbHeight = _metadata.bbHeight;

		if (__COLLAGE_VERBOSE) {
			__CollageTrace($"{__owner.__GetName()} \"{_spriteData.__name}\"is currently being processed... 0/{string(_spriteInfo.num_subimages)}");
		}
		
	
		var _imageInfo = new __CollageImageClass(_spriteData.__name,
				_spriteInfo.width,
				_spriteInfo.height,
				_spriteInfo.num_subimages,
				_spriteData.__speed,
				_spriteData.__speedType,
				_drawW, 
				_drawH, 
				_tiling, 
				_ratio, 
				_xOffset, 
				_yOffset, 
				_hashes
		);

		__SetImage(_spriteData.__name, _imageInfo);


		var _texWidth = __currentTexPage.GetWidth();
		var _texHeight = __currentTexPage.GetHeight();

		if (_useBboxPoints) {
			for(var _sub = 0; _sub < _subImages; ++_sub) {
				var _emptySpaceSize = 0xFFFFFF;
				var _emptySpaceId = -1;
				// Skip over since UVs already exist!
				if (_imageInfo.__subImagesArray[_sub] != undefined) continue;
				     
				//if (!__forceNewTexturePage) {
					var _len = array_length(__bboxPoints);
					for(var _n = 0; _n < _len; ++_n) {
					     if( _bbWidth <= __bboxPoints[_n].right && _bbHeight <= __bboxPoints[_n].bottom) {
					         var _resolve = (__bboxPoints[_n].right + __bboxPoints[_n].bottom ) / 2;
							 if (_resolve < _emptySpaceSize) {
					             _emptySpaceSize = _resolve;
					             _emptySpaceId = _n;
					        } 
					    }
					}   
				//}    
			 
				if (_emptySpaceId != -1) {
        		   var _currentPoint = __bboxPoints[_emptySpaceId];
					__DrawImage(_spriteData, _spriteID, _sub, _drawX, _drawY, _drawW, _drawH, _currentPoint, _ratio, _wScale, _hScale);
					        
					var _uvX = _currentPoint.left + ((_tiling[0]) ? 2 : 0); 
					var _uvY = _currentPoint.top + ((_tiling[1]) ? 2 : 0);
					var _uvW = _wScale;
					var _uvH = _hScale;
					var _uvs = new __CollageImageUVsClass(__currentTexPage, __owner.__texPageCount, _uvX, _uvY, _uvW, _uvH, _drawX, _drawY, _ogW, _ogH, _xOffset, _yOffset);
					_imageInfo.__subImagesArray[_sub] = _uvs;
					// Store next available space
					if( _bbHeight < _currentPoint.bottom){ 
					    var _struct = __CollageBboxRequest(_currentPoint.left, _currentPoint.top + _bbHeight + __sep + ((_tiling[1]) ? 2 : 0), _currentPoint.right , _currentPoint.bottom - _bbHeight - __sep - ((_tiling[1]) ? 2 : 0));
						array_push(__bboxPoints, _struct);
					}
					
					if( _bbWidth < _currentPoint.right) {
						var _struct = __CollageBboxRequest(_currentPoint.left + _bbWidth + __sep + ((_tiling[0]) ? 2 : 0), _currentPoint.top, _currentPoint.right - _bbWidth - __sep - ((_tiling[0]) ? 2 : 0), _bbHeight + ((_tiling[1]) ? 2 : 0));
						array_push(__bboxPoints,_struct);
					} 
					
					// Remove non-empty area
					if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + "\"" + _spriteData.__name + "\"" + " is currently being processed... " + string(_sub+1) + "/" + string(_subImages));
					if (_sub == _subImages-1) {
						if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + "\"" + _spriteData.__name + "\"" + " has been processed...");	
					}
					__CollageBboxStore(__bboxPoints[_emptySpaceId]);
					array_delete(__bboxPoints, _emptySpaceId, 1);
					array_push(__bboxPoints, __CollageBboxRequest(__sep, __sep, _texWidth - __sep, _texHeight - __sep));
				}   
			}
			/*
			var _externalFrames = _spriteData.__externalFrames;
			if (array_length(_externalFrames) > 0) {
				for(var _sub = _subStart; _sub < _subImages; ++_sub) {
					var _emptySpaceSize = 0xFFFFFF;
					var _emptySpaceID = -1;
					// Skip over since UVs already exist!
					if (_imageInfo.__subImagesArray[_sub] != undefined) continue;
					
					if (!__forceNewTexturePage) {
						var _len = array_length(bboxPoints);
						for(var _n = 0; _n < _len; ++_n) {
						     if( _bbWidth <= bboxPoints[_n].right && _bbHeight <= bboxPoints[_n].bottom) {
						         var _resolve = (bboxPoints[_n].right + bboxPoints[_n].bottom ) / 2;
								 if (_resolve < _emptySpaceSize) {
						             _emptySpaceSize = _resolve;
						             _emptySpaceID = _n;
						        } 
						    }
						}
					}
				}
			}*/
		} else {

		}
	};
}