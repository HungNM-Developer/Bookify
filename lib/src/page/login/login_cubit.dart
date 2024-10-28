import 'package:bookify/core/cubit_status.dart';
import 'package:bookify/live_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(
      status: CubitStatus.loading,
    ));
    try {
      final response = await LiveData.dio.post(
        'https://apilibrary-xi.vercel.app/api/users/login',
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
        options: Options(
          headers: {},
          followRedirects: false,
          receiveDataWhenStatusError: true,
          receiveTimeout: const Duration(seconds: 8),
          sendTimeout: const Duration(seconds: 8),
          validateStatus: (status) => (status ?? 501) <= 500,
        ),
      );
      if (response.statusCode == 200) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        LiveData.accessToken = response.data['token'] ?? '';
        LiveData.userName = response.data['username'] ?? '';
        LiveData.role = response.data['role'] ?? '';
        LiveData.email = email;
        _prefs.setString('ACCESS_TOKEN', LiveData.accessToken);
        _prefs.setString('USERNAME', LiveData.userName);
        _prefs.setString('ROLE', LiveData.role);
        _prefs.setString('EMAIL', LiveData.email);
        emit(state.copyWith(
          status: CubitStatus.success,
          message: response.data['message'] ?? '',
          hasAuth: LiveData.accessToken.isNotEmpty,
          data: response.data,
        ));
      } else {
        emit(state.copyWith(
          status: CubitStatus.error,
          message: response.data['message'] ?? '',
          data: response.data,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CubitStatus.error,
        message: e.toString(),
      ));
    }
  }
}
