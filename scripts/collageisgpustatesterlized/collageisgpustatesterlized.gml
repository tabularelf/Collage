/// @func CollageIsGPUStateSterlized()
/* Feather ignore all */
function CollageIsGPUStateSterlized() {
	static _instance = __CollageGPUStateSingleton();
	return _instance.isSterilized;
}