class BorrowRequestState {
  final bool isLoading;
  final dynamic result;
  final String? error;

  const BorrowRequestState({
    this.isLoading = false,
    this.result,
    this.error,
  });

  BorrowRequestState copyWith({
    bool? isLoading,
    dynamic result,
    String? error,
  }) {
    return BorrowRequestState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
