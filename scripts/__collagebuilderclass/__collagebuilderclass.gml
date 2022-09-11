/// @ignore
/* Feather ignore all */
function __CollageBuilderClass() constructor {
	owner = other;
	bboxPoints = [];
	init = false;
	freeSpacePoints = [];
	
	static __checkImage = function(_str) {
		/* Feather ignore once GM2047 */
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			return variable_struct_exists(global.__CollageImageMap, _str);	
		} else {
			return variable_struct_exists(owner.__imageMap, _str);	
		}
	}
	
	static __getImage = function(_str) {
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			return global.__CollageImageMap[$ _str];	
		} else {
			return owner.__imageMap[$ _str];	
		}
	}
	
	static __setImage = function(_str, _data) {
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			global.__CollageImageMap[$ _str] = _data;	
		} else {
			owner.__imageMap[$ _str] = _data;	
		}
	}
	
	static __bboxSort = function(_elm1, _elm2) {
		var _sizeA, _sizeB;
		_sizeA = (_elm2.bbWidth + _elm2.bbHeight) * .5; 
		_sizeB = (_elm1.bbWidth + _elm1.bbHeight) * .5;
		return  _sizeA - _sizeB;
	}
	
	static __build = function() {	
		// Store building time for verbose later
		var _startTime = get_timer();
		
		// Separate entries
		var _len = array_length(owner.__batchImageList);
		var _collageName = (owner.name != undefined) ? owner.name + " - ": "";
		if (_len == 0) {
			__CollageTrace(_collageName +"Building was commenced but there was no images to pack!");
			exit;
		}
		
		__CollageTrace(_collageName +"Building commenced! Attempting to pack " + string(array_length(owner.__batchImageList)) + " images!");
		// Begin gather texture data
		var _crop = owner.crop;
		var _texWidth = owner.width;
		var _texHeight = owner.height;
		var _spriteList = owner.__batchImageList;
		var _batchMode = (owner.__state == __CollageStates.BATCHING);
		var _normalSprites = array_create(array_length(_spriteList));
		var _3DSprites = array_create(array_length(_spriteList));
		var _texPage = array_length(owner.__texPageArray) == 0 ? new __CollageTexturePageClass(_texWidth, _texHeight) : owner.__texPageArray[array_length(owner.__texPageArray)-1];
		var _sep = owner.separation;
		var _3DArraySize = 0;
		var _normalArraySize = 0;
		var _optimize = owner.optimize;

		CollageSterlizeGPUState();
		
		// Early check out of boundaries + data.
		// This check is here to ensure that sprites are both ordered, and that we only get sprites that are valid.
		var _i = 0;
		repeat(_len) {
				var _spriteData = _spriteList[_i];
				var _spriteID = _spriteData.spriteID;
				var _spriteInfo = sprite_get_info(_spriteID);
				var _sprWidth = _spriteInfo.width;
				var _sprHeight = _spriteInfo.height;
				var _drawX, _drawY, _drawW, _drawH;
				var _xScale = 1;
				var _yScale = 1;
				var _forceScaled = false;
				if (_crop == true) {
					_drawX =		sprite_get_bbox_left(_spriteID);
					_drawY =		sprite_get_bbox_top(_spriteID);
					_drawW =	sprite_get_bbox_right(_spriteID)-_drawX+1;
					_drawH =		sprite_get_bbox_bottom(_spriteID)-_drawY+1;	
				} else {
					_drawX = 0;
					_drawY = 0;
					_drawW = _sprWidth;
					_drawH =  _sprHeight;		
				}
				
				var _bbWidth = _drawW;
				var _bbHeight = _drawH;
				var _ratio = 1;
				
				// Exit early code
				if (_drawW > _texWidth || _drawH > _texHeight) {
					if (!__COLLAGE_SCALE_TO_TEXTURES_ON_PAGE) {
						__CollageTrace("Image " + string(_spriteData.name) + " is too big! Skipping...");
						if (_spriteData.isCopy) {
							sprite_delete(_spriteID);
						}
						array_delete(_spriteList, _i, 1);
						--_i;
					} else {
						_xScale = _texWidth/_drawW;
						_yScale = _texHeight/_drawH;
						_ratio = min(_xScale, _yScale);
						_bbWidth = _ratio * _drawW;
						_bbHeight = _ratio * _drawH;
						//_xScale = _xScale / (_ratio*2);
						//_yScale = _yScale / (_ratio*2);
						//_drawW = _bbWidth;
						//_drawH = _bbHeight;
						__CollageTrace("Sprite " + string(_spriteData.name) + " has been rescaled from width: " +  string(_drawW) + ", height: " + string(_drawH) + ", " + " to width: " + string(_bbWidth) + ", height: " + string(_bbHeight));
					}
				}
				
				
				var _newSpriteData = {
					spriteData: _spriteData,
					spriteID: _spriteID,
					spriteInfo: _spriteInfo,
					spriteWidth: _sprWidth,
					spriteHeight: _sprHeight,
					xScale: _xScale,
					yScale: _xScale,
					ratio: _ratio,
					bbWidth: _bbWidth,
					bbHeight: _bbHeight,
					drawX: _drawX,
					drawY: _drawY,
					drawW: _drawW,
					drawH: _drawH,
					wScale: _drawW * _ratio,
					hScale: _drawH * _ratio,
					originalWidth: _sprWidth,
					originalHeight: _sprHeight,
				}
				_spriteList[_i] = _newSpriteData;
				++_i;
		}
		_len = array_length(_spriteList);
		
		
		// Sort out by bbox
		if (_len > 1) {
			array_sort(_spriteList, __bboxSort);
		}
		
		var _i = 0;
		
		// Separate sprites into two groups
		repeat(_len) {
		if (_spriteList[_i].spriteData.is3D) {
			_3DSprites[_3DArraySize++] = _spriteList[_i];	
		} else {
			_normalSprites[_normalArraySize++] = _spriteList[_i];	
		}	
		
			++_i;
		}
		
					
		// Resize back down
		array_resize(_normalSprites, _normalArraySize);	
		
		array_resize(_3DSprites, _3DArraySize);	
		
		// Clear List
		array_delete(_spriteList, 0, _len);
		
		if (init == false) {
			array_push(bboxPoints, new __CollageBBoxClass(_sep, _sep, _texWidth - _sep, _texHeight - _sep));
			init = true;
		}
		
		// Normal texture pages first
		if (array_length(_normalSprites) > 0) {
			// Begin texture mapping
			_texPage.start();	
		}
		for(var _ii = 0; _ii < array_length(_normalSprites); ++_ii) {
			var _spriteStruct = _normalSprites[_ii];
			var _spriteData = _spriteStruct.spriteData;
				var _spriteID = _spriteStruct.spriteID;
				var _spriteInfo = _spriteStruct.spriteInfo;
				var _sprWidth = _spriteStruct.spriteWidth;
				var _sprHeight = _spriteStruct.spriteHeight;
				var _drawX = _spriteStruct.drawX, _drawY = _spriteStruct.drawY, _drawW = _spriteStruct.drawW, _drawH = _spriteStruct.drawH;
				var _xScale = _spriteStruct.xScale;
				var _yScale = _spriteStruct.yScale;
				var _wScale = _spriteStruct.wScale;
				var _hScale = _spriteStruct.hScale;
				var _ogW = _spriteStruct.originalWidth;
				var _ogH = _spriteStruct.originalHeight;
				var _xOffset = _spriteData.xOrigin;
				var _yOffset = _spriteData.yOrigin;
				
				
				var _bbWidth = _spriteStruct.bbWidth;
				var _bbHeight = _spriteStruct.bbHeight;
				var _ratio = _spriteStruct.ratio;
				
				var _subStart = 0;
				if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... 0/" + string(_spriteInfo.num_subimages));
				if (__checkImage(_spriteData.name)) {
					switch(__COLLAGE_IMAGE_NAME_COLLISION_HANDLE) {
						case 0:
							__CollageTrace(_collageName + _spriteData.name + " already exists! Skipping...");
							--_normalArraySize;
							continue;
							break;
						case 1:
							if !(((_spriteInfo.width == __getImage(_spriteData.name).width) && (_spriteInfo.height == __getImage(_spriteData.name).height))
							&& (_spriteInfo.bbox_right-_spriteInfo.bbox_left+1 == __getImage(_spriteData.name).cropWidth) && (_spriteInfo.bbox_bottom-_spriteInfo.bbox_top+1 == __getImage(_spriteData.name).cropHeight)) {
								var _spriteName = _spriteData.name;
								var _num = 1;
								var _name = _spriteName + string(_num);
								while(__checkImage(_name)) {
										var _name = _spriteName + string(++_num);
								}
								__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
								_spriteData.name = _name;
								
								var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
								// Lets add it to database
								__setImage(_spriteData.name, _imageInfo);
								
								var _subImages = _spriteInfo.num_subimages;
							} else {
								// Same width/height
								// Loop
								var _subImageLen = _spriteInfo.num_subimages;
								var _imageInfo = CollageGetImageInfo(_spriteData.name);
								var _uvsArray = _imageInfo.subImagesArray;
								var _uvsArrayLength = array_length(_uvsArray);
								var _uvi = 0;
								var _currentTexPage = _texPage;
								var _newTexPage = _texPage;
								var _changedTexPage = false;
								gpu_set_blendenable(true);
								repeat(_subImageLen) {
									if (_uvi >= _uvsArrayLength) break;
									var _uvs = _uvsArray[_uvi++];
									 _newTexPage = _uvs.texturePageStruct;
									if (_texPage != _newTexPage) {
										_changedTexPage = true;
										_texPage.finish();
										_texPage = _newTexPage;
										_texPage.start();
									}
									gpu_set_blendmode(bm_subtract);
									draw_rectangle_color(_uvs.left, _uvs.top, _uvs.left+_uvs.right,_uvs.top+ _uvs.bottom, c_black, c_black, c_black, c_black, false);
									gpu_set_blendmode(bm_normal);
									draw_sprite_part_ext(_spriteID, _uvi-1, _drawX, _drawY, _drawW,  _drawH, _uvs.left, _uvs.top, _ratio, _ratio, c_white, 1);
									if (__COLLAGE_RENDER_DEBUG_LINES) {
										draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
										draw_rectangle(_uvs.left+1,_uvs.top+1,_uvs.left+_drawW-2,_uvs.top+_drawH-2, true);
										draw_set_colour(c_white);	
									}
								}
								
								if (_changedTexPage) {
									_texPage.finish();
									_texPage = _currentTexPage;
									_texPage.start();
								}
								
								gpu_set_blendenable(false);
								var _subImages = _subImageLen;
								var _subStart = (_subImageLen > _uvsArrayLength) ? (_subImageLen - _uvsArrayLength) : _subImageLen;
								_imageInfo.subImagesCount = _subImageLen;
								__CollageTrace(_collageName + _spriteData.name + " overwritten! (" + string(_subImageLen) + "/" + string(_uvsArrayLength) + ") Left over: " + string(max(_subImageLen - _uvsArrayLength, 0)));
							}
						break;
						
						case 2:
							var _spriteName = _spriteData.name;
							var _num = 1;
							var _name = _spriteName + string(_num);
							while(__checkImage(_name)) {
									var _name = _spriteName + string(++_num);
							}
							__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
							_spriteData.name = _name;
							
							var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
							// Lets add it to database
							__setImage(_spriteData.name, _imageInfo);
							var _subImages = _spriteInfo.num_subimages;
						break;
					}
				} else {
					var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio, _xOffset, _yOffset);
					// Lets add it to database
					__setImage(_spriteData.name, _imageInfo);
					
					var _subImages = _spriteInfo.num_subimages;
					owner.imageCount++;
					array_push(owner.__imageList, _imageInfo);
					if (__COLLAGE_IMAGES_ARE_PUBLIC) owner.__imageMap[$ _spriteData.name] = _imageInfo;
				}
				for(var _sub = _subStart; _sub < _subImages; ++_sub) {
					var _emptySpaceSize = 0xFFFFFF;
					var _emptySpaceID = -1;
					var _n = 0;
					for( var _n = 0; _n < array_length(bboxPoints); ++_n) {
					     if( _bbWidth <= bboxPoints[_n].right && _bbHeight <= bboxPoints[_n].bottom) {
					         var _resolve = (bboxPoints[_n].right + bboxPoints[_n].bottom ) / 2;
							 if (_resolve < _emptySpaceSize) {
					             _emptySpaceSize = _resolve;
					             _emptySpaceID = _n;
					        } 
					    }
					}
					
					// Refresh empty areas
					
					if(_emptySpaceID != -1) {
						var _currentPoint = bboxPoints[_emptySpaceID];
						draw_sprite_part_ext(_spriteID , _sub , _drawX  , _drawY , _drawW, _drawH, _currentPoint.left, _currentPoint.top, _ratio, _ratio, c_white, 1);
						/*if (_forceScaled) {
							_drawW = _drawW * _ratio;
							_drawH = _drawH * _ratio;
						}*/
						if (__COLLAGE_RENDER_DEBUG_LINES) {
							draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
							draw_rectangle(_currentPoint.left+1,_currentPoint.top+1,_currentPoint.left+_wScale-2,_currentPoint.top+_hScale-2, true);
							draw_set_colour(c_white);	
						}
						
						var _uvX = _currentPoint.left; 
						var _uvY = _currentPoint.top;
						var _uvW = _wScale;
						var _uvH = _hScale;
						//show_debug_message([_currentPoint.left,_currentPoint.top,_currentPoint.left+_drawW,_currentPoint.top+_drawH]);
						var _uvs = new __CollageImageUVsClass(_texPage, owner.texPageCount, _uvX, _uvY, _uvW, _uvH, _drawX, _drawY, _ogW, _ogH, /*_sprWidth - _drawW - 2, _sprHeight - _drawH - 2,*/ _imageInfo.xoffset, _imageInfo.yoffset);
						_imageInfo.subImagesArray[_sub] = _uvs;
						//if (!_forceScaled) {
							// Store next available space
							if( _bbHeight < _currentPoint.bottom){ 
							    var _struct = new __CollageBBoxClass(_currentPoint.left, _currentPoint.top + _drawH + _sep, _currentPoint.right , _currentPoint.bottom - _drawH - _sep);
								//{left: _currentPoint.left , top: _currentPoint.top + _drawH + _sep , right: _currentPoint.right , bottom: _currentPoint.bottom - _drawH - _sep};
								//var _struct = new __CollageBBoxClass(_currentPoint.left, _texHeight - (_currentPoint.top + _drawH + _sep), _currentPoint.right, _texHeight - (_currentPoint.bottom - _drawH - _sep), _texWidth, _texHeight);
								array_push(bboxPoints,_struct);
							}
							
							if( _bbWidth < _currentPoint.right) {
								var _struct = new __CollageBBoxClass(_currentPoint.left + _drawW + _sep, _currentPoint.top, _currentPoint.right - _drawW - _sep, _drawH);
								//var _struct = new __CollageBBoxClass(_texWidth - (_currentPoint.left + _drawW + _sep), _currentPoint.top, _texWidth(_currentPoint.right - _drawW - _sep), _drawH);
								array_push(bboxPoints,_struct);
							} 
						/*} else {
							array_push(bboxPoints, {left: 0, right: 0, top: 0, bottom: 0});
						}*/
						// Remove non-empty area
						if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... " + string(_sub+1) + "/" + string(_subImages));
						if (_sub == _subImages-1) {
							if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " has been processed...");	
						}
						array_delete(bboxPoints, _emptySpaceID, 1);
						
						if (_batchMode) && (_optimize) {
							// Loop over sub entries
							//var _bestEntries = [];
							var _bestEntryWidth = -1;
							var _bestEntryHeight = -1;
							var _bestEntry = undefined;
							var _bestEntryPos = 0;
							var _lenNormSprites = array_length(_normalSprites);
							for(var _iii = _ii+1; _iii < _lenNormSprites; _iii++;) {//repeat(array_length(_normalSprites)-_iii) {
								var _n = 0;
								repeat(array_length(bboxPoints)) {
								     if(_normalSprites[_iii].bbWidth <= bboxPoints[_n].right && _normalSprites[_iii].bbHeight <= bboxPoints[_n].bottom) && 
									 (_normalSprites[_iii].bbWidth > _bestEntryWidth && _normalSprites[_iii].bbHeight > _bestEntryHeight) {
								         var _resolve = (bboxPoints[_n].right + bboxPoints[_n].bottom ) / 2;
										 if (_resolve < 0xFFFFFF) {
											 _bestEntryWidth = _normalSprites[_iii].bbWidth;
											 _bestEntryHeight = _normalSprites[_iii].bbHeight;
											 _bestEntry = _normalSprites[_iii];
											 _bestEntryPos = _iii;
											 break;
								        } 
								    }
									++_n;
								}
							}
								
								if (!is_undefined(_bestEntry)) {
									var _entryA = _normalSprites[_ii+1];
									var _entryB = _bestEntry;
									_normalSprites[_ii+1] = _entryB;
									_normalSprites[_bestEntryPos] = _entryA;
								}
							}
					} else {
						
						// We declare this finished
						_texPage.finish();
						
						// Unload VRAM
						if (__COLLAGE_BUILDER_VRAM_CLEAR) {
							_texPage.__UnloadVRAM();	
						}
						
						// Save texture page
						if (owner.texPageCount == 0) || (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
							owner.__texPageArray[owner.texPageCount++] = _texPage;
						}
						_texPage = new __CollageTexturePageClass(_texWidth, _texHeight);
						_texPage.start();
						
						
						// Clear spaces and add new one
						array_delete(bboxPoints,0,array_length(bboxPoints));
						array_push(bboxPoints, new __CollageBBoxClass(_sep, _sep, _texWidth - _sep, _texHeight - _sep));
						--_sub;
					}
				}
					
		}
		
		// Finished
		if (array_length(_normalSprites) > 0) {
			_texPage.finish();
		}
		
		// Give texture page + safety check
		if (array_length(_normalSprites) > 0) {
			if (owner.texPageCount != 0) {
				if (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
					owner.__texPageArray[owner.texPageCount++] = _texPage;
				}
			} else if (array_length(owner.__texPageArray) > 0) && (owner.__texPageArray[owner.texPageCount] == _texPage) {
				// Do nothing
			} else {
				owner.__texPageArray[owner.texPageCount++] = _texPage;	
			}
		}
		
		// Now do 3D textures
		for(var _ii = 0; _ii < array_length(_3DSprites); ++_ii) {
			var _spriteStruct = _3DSprites[_ii];
			var _spriteData = _spriteStruct.spriteData;
				var _spriteID = _spriteStruct.spriteID;
				var _spriteInfo = _spriteStruct.spriteInfo;
				var _sprWidth = _spriteStruct.spriteWidth;
				var _sprHeight = _spriteStruct.spriteHeight;
				var _drawX = _spriteStruct.drawX, _drawY = _spriteStruct.drawY, _drawW = _spriteStruct.drawW, _drawH = _spriteStruct.drawH;
				var _xScale = _spriteStruct.xScale;
				var _yScale = _spriteStruct.yScale;
				var _wScale = _spriteStruct.wScale;
				var _hScale = _spriteStruct.hScale;
				var _ogW = _spriteStruct.originalWidth;
				var _ogH = _spriteStruct.originalHeight;
				
				
				var _bbWidth = _spriteStruct.bbWidth;
				var _bbHeight = _spriteStruct.bbHeight;
				var _ratio = _spriteStruct.ratio;
				
				var _subStart = 0;
				if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... 0/" + string(_spriteInfo.num_subimages));
				if (__checkImage(_spriteData.name)) {
					switch(__COLLAGE_IMAGE_NAME_COLLISION_HANDLE) {
						case 0:
							__CollageTrace(_collageName + _spriteData.name + " already exists! Skipping...");
							--_3DArraySize;
							continue;
						break;
						
						case 1:
							if !(((_spriteInfo.width == __checkImage(_spriteData.name).width) && (_spriteInfo.height == __checkImage(_spriteData.name).height))
							&& (_spriteInfo.bbox_right-_spriteInfo.bbox_left+1 == __checkImage(_spriteData.name).cropWidth) && (_spriteInfo.bbox_bottom-_spriteInfo.bbox_top+1 == __checkImage(_spriteData.name).cropHeight)) {
								var _spriteName = _spriteData.name;
								var _num = 1;
								var _name = _spriteName + string(_num);
								while(__checkImage(_spriteData.name)) {
										var _name = _spriteName + string(++_num);
								}
								__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
								_spriteData.name = _name;
								
								var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
								// Lets add it to database
								__setImage(_spriteData.name, _imageInfo);
								
								var _subImages = _spriteInfo.num_subimages;
							} else {
								// Same width/height
								// Loop
								var _subImageLen = _spriteInfo.num_subimages;
								var _imageInfo = CollageGetImageInfo(_spriteData.name);
								var _uvsArray = _imageInfo.subImagesArray;
								var _uvsArrayLength = array_length(_uvsArray);
								var _uvi = 0;
								var _newTexPage = _texPage;
								_texPage.start();
								repeat(_subImageLen) {
									if (_uvi >= _uvsArrayLength) break;
									var _uvs = _uvsArray[_uvi++];
									_newTexPage = _uvs.texturePageStruct;
									
									if (_texPage != _newTexPage) {
										_texPage.finish();
										_texPage = _newTexPage;
										_texPage.start();	
									}
									gpu_set_blendenable(true);
									gpu_set_blendmode(bm_subtract);
									draw_rectangle_color(_uvs.left, _uvs.top, _uvs.left+_uvs.right,_uvs.top+ _uvs.bottom, c_black, c_black, c_black, c_black, false);
									gpu_set_blendmode(bm_normal);
									gpu_set_blendenable(false);
									draw_sprite_part_ext(_spriteID, _uvi-1, _drawX, _drawY, _drawW,  _drawH, _uvs.left, _uvs.top, _ratio, _ratio, c_white, 1);
									if (__COLLAGE_RENDER_DEBUG_LINES) {
										draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
										draw_rectangle(_uvs.left+1,_uvs.top+1,_uvs.left+_drawW-2,_uvs.top+_drawH-2, true);
										draw_set_colour(c_white);	
									}
								}
								_texPage.finish();
								gpu_set_blendenable(false);
								var _subImages = _subImageLen;
								var _subStart = (_subImageLen > _uvsArrayLength) ? (_subImageLen - _uvsArrayLength) : _subImageLen;
								_imageInfo.subImagesCount = _subImageLen;
								__CollageTrace(_spriteData.name + " overwritten! (" + string(_subImageLen) + "/" + string(_uvsArrayLength) + ") Left over: " + string(max(_subImageLen - _uvsArrayLength, 0)));
							}
						break;
						
						case 2:
							var _spriteName = _spriteData.name;
							var _num = 1;
							var _name = _spriteName + string(_num);
							while(__checkImage(_name)) {
									var _name = _spriteName + string(++_num);
							}
							__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
							_spriteData.name = _name;
							
							var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
							// Lets add it to database
							__setImage(_spriteData.name, _imageInfo);
							var _subImages = _spriteInfo.num_subimages;
						break;
					}
				} else {
					var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
					// Lets add it to database
					__setImage(_spriteData.name, _imageInfo);
					
					var _subImages = _spriteInfo.num_subimages;
					owner.imageCount++;
					array_push(owner.__imageList, _imageInfo);
					if (__COLLAGE_IMAGES_ARE_PUBLIC) owner.__imageMap[$ _spriteData.name] = _imageInfo;
				}
				for(var _sub = _subStart; _sub < _subImages; ++_sub) {
						_texPage = new __CollageTexturePageClass(_texWidth, _texHeight);
						_texPage.start();
						draw_sprite_part_ext(_spriteID , _sub , _drawX  , _drawY , _drawW, _drawH, 0, 0, _ratio, _ratio, c_white, 1);
						/*if (_forceScaled) {
							_drawW = _drawW * _ratio;
							_drawH = _drawH * _ratio;
						}*/
						if (__COLLAGE_RENDER_DEBUG_LINES) {
							draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
							draw_rectangle(_spriteInfo.bbox_left+1,_spriteInfo.bbox_top+1,_spriteInfo.bbox_left+_wScale-2,_spriteInfo.bbox_top+_hScale-2, true);
							draw_set_colour(c_white);	
						}
						
						var _uvX = 0; 
						var _uvY = 0;
						var _uvW = _wScale;
						var _uvH = _hScale;
						//show_debug_message([_currentPoint.left,_currentPoint.top,_currentPoint.left+_drawW,_currentPoint.top+_drawH]);
						var _uvs = new __CollageImageUVsClass(_texPage, owner.texPageCount, _uvX, _uvY, _uvW, _uvH, _drawX, _drawY, _ogW, _ogH,/*_sprWidth - _drawW - 2, _sprHeight - _drawH - 2,*/ _imageInfo.xoffset, _imageInfo.yoffset);
						_imageInfo.subImagesArray[_sub] = _uvs;
						// We declare this finished
						_texPage.finish();
						
						// Unload VRAM
						if (__COLLAGE_BUILDER_VRAM_CLEAR) {
							_texPage.__UnloadVRAM();	
						}
						
						// Save texture page
						if (owner.texPageCount == 0) || (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
							owner.__texPageArray[owner.texPageCount++] = _texPage;
						}
						
						if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... " + string(_sub+1) + "/" + string(_subImages));
						if (_sub == _subImages-1) {
							if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " has been processed...");	
						}
					} 
				}			
		
		// Give texture page + safety check
		if (array_length(_3DSprites) > 0) {
			if (owner.texPageCount != 0) {
				if (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
					owner.__texPageArray[owner.texPageCount++] = _texPage;
				}
			} else if (array_length(owner.__texPageArray) > 0) && (owner.__texPageArray[owner.texPageCount] == _texPage) {
				// Do nothing
			} else {
				owner.__texPageArray[owner.texPageCount++] = _texPage;	
			}
		}
		
		
		// Remove Sprites
		var _len = array_length(_normalSprites);
		var _i = 0;
		repeat(_len) {
			if (_normalSprites[_i].spriteData.isCopy) {
				sprite_delete(_normalSprites[_i].spriteID);
			}
			++_i;
		}
		
		var _len = array_length(_3DSprites);
		var _i = 0;
		repeat(_len) {
			if (_3DSprites[_i].spriteData.isCopy) {
				sprite_delete(_3DSprites[_i].spriteID);
			}
			++_i;
		}
		array_resize(owner.__batchImageList, 0);
		CollageRestoreGPUState();
		
		__CollageTrace(_collageName + "Building finished! Packed " + string(_normalArraySize) + " images and " + string(_3DArraySize) + " images with separate texture pages.");
		var _finalTime = (get_timer()-_startTime)/1000;
		if (__COLLAGE_VERBOSE) __CollageTrace(_collageName + "Building took " + string(_finalTime) + "ms");
	}
}