import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../core/cubit_status.dart';
import '../../../live_data.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState());

  Future<void> borrowBook(
    String titleBook,
    String borrowDate,
    String returnDate,
  ) async {
    emit(state.copyWith(
      status: CubitStatus.loading,
    ));
    try {
      final response = await LiveData.dio.post(
        'https://apilibrary-xi.vercel.app/api/borrow-requests',
        data: {
          'username': LiveData.userName,
          'title': titleBook,
          'borrowDate': borrowDate,
          'returnDate': returnDate,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${LiveData.accessToken}',
          },
          followRedirects: false,
          receiveDataWhenStatusError: true,
          receiveTimeout: const Duration(seconds: 8),
          sendTimeout: const Duration(seconds: 8),
          validateStatus: (status) => (status ?? 501) <= 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(
          status: CubitStatus.success,
          statusCode: 200,
          message: response.data['message'] ?? '',
        ));
      } else {
        emit(state.copyWith(
          status: CubitStatus.error,
          statusCode: response.statusCode,
          message: response.statusMessage ?? response.data['message'] ?? '',
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
