
if (array_length(asyncList) > 0) {
	__CollageThrow("Async jobs are still in progress! Please make sure to keep __CollageAsyncManager alive!");
}