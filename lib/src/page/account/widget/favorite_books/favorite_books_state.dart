class FavoriteBooksState {
	final bool isLoading;
	final String? error;
	  
	const FavoriteBooksState({
		this.isLoading = false,
		this.error,
	});
	  
	FavoriteBooksState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return FavoriteBooksState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
