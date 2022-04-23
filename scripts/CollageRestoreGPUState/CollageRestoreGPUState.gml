function CollageRestoreGPUState() {
			var _instance = __CollageGPUStateSingleton();
			// Restore settings
			gpu_set_blendenable(_instance.gpuBlendEnable);
			gpu_set_blendmode_ext_sepalpha(_instance.gpuBlendMode);
			gpu_set_colourwriteenable(_instance.gpuColourWrite);
			gpu_set_alphatestenable(_instance.gpuAlphaTest);
			gpu_set_texfilter(_instance.gpuTexFilter);
			gpu_set_fog(_instance.gpuFog);
			draw_set_lighting(_instance.gpuLighting);
			draw_set_colour(_instance.gpuColour);
			draw_set_alpha(_instance.gpuAlpha);
			gpu_set_zwriteenable(_instance.gpuZWrite);
			gpu_set_ztestenable(_instance.gpuZTest);
			gpu_set_cullmode(_instance.gpuCullmode);
			gpu_set_zfunc(_instance.gpuZFunc);
			gpu_set_tex_filter(_instance.gpuFiltering);
			gpu_set_tex_mip_enable(_instance.gpuMipEnabled);
			matrix_set(matrix_world, _instance.matrixWorld);
			matrix_set(matrix_view, _instance.matrixView);
			matrix_set(matrix_projection, _instance.matrixProj);
			if (_instance.shader != -1) {
				shader_set(_instance.shader);	
			}
}