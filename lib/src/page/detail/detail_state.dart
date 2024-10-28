part of 'detail_cubit.dart';

class DetailState {
  final CubitStatus status;
  final int? statusCode;
  final String message;
  final String selectedDateBorrow;
  final String selectedDateReturn;

  DetailState({
    this.status = CubitStatus.initial,
    this.statusCode,
    this.message = '',
    this.selectedDateBorrow = '',
    this.selectedDateReturn = '',
  });
  DetailState copyWith({
    CubitStatus? status,
    int? statusCode,
    String? message,
    String? selectedDateBorrow,
    String? selectedDateReturn,
  }) {
    return DetailState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      selectedDateBorrow: selectedDateBorrow ?? this.selectedDateBorrow,
      selectedDateReturn: selectedDateReturn ?? this.selectedDateReturn,
    );
  }
}
