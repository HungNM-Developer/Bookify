class AddEditState {
	final bool isLoading;
	final String? error;
	  
	const AddEditState({
		this.isLoading = false,
		this.error,
	});
	  
	AddEditState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return AddEditState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
