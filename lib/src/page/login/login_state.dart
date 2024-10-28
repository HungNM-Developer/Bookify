import 'package:bookify/core/cubit_status.dart';

class LoginState {
  final CubitStatus status;
  final String message;
  final bool hasAuth;
  final dynamic data;

  const LoginState({
    this.status = CubitStatus.initial,
    this.message = '',
    this.hasAuth = false,
    this.data,
  });

  LoginState copyWith({
    CubitStatus? status,
    String? message,
    bool? hasAuth,
    dynamic data,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      hasAuth: hasAuth ?? this.hasAuth,
      data: data ?? this.data,
    );
  }
}
