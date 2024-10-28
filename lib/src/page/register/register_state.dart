import '../../../core/cubit_status.dart';

class RegisterState {
  final CubitStatus status;
  final String message;
  final dynamic data;

  const RegisterState({
    this.status = CubitStatus.initial,
    this.message = '',
    this.data,
  });

  RegisterState copyWith({
    CubitStatus? status,
    String? message,
    dynamic data,
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
