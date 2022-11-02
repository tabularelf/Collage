/// @func CollageIsGPUStateSterlized()
function CollageIsGPUStateSterlized() {
	static _instance = __CollageGPUStateSingleton();
	return _instance.isSteralized;
}