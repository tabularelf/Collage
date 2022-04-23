function __CollageGPUStateSingleton() {
	static _instance = {
		gpuBlendEnable: undefined,
		gpuBlendMode: undefined,
		gpuColourWrite: undefined,
		gpuAlphaTest: undefined,
		gpuTexFilter: undefined,
		gpuFog: undefined,
		gpuLighting: undefined,
		gpuZWrite: undefined,
		gpuZTest: undefined,
		gpuCullmode: undefined,
		gpuZFunc: undefined,
		gpuFlitering: undefined,
		gpuMipEnabled: undefined,
		matrixWorld: undefined,
		matrixView: undefined,
		matrixProj: undefined,
		shader: -1
	}
	
	return _instance;
}