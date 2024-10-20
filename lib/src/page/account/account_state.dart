class AccountState {
	final bool isLoading;
	final String? error;
	  
	const AccountState({
		this.isLoading = false,
		this.error,
	});
	  
	AccountState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return AccountState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
