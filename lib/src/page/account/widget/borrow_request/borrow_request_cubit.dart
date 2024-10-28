import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/account/widget/borrow_request/borrow_request_state.dart';

import '../../../../../live_data.dart';

class BorrowRequestCubit extends Cubit<BorrowRequestState> {
  BorrowRequestCubit() : super(const BorrowRequestState(isLoading: true));

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      final response = await LiveData.dio.get(
        'https://apilibrary-xi.vercel.app/api/borrow-requests',
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
          isLoading: false,
          result: response.data['data'],
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: response.statusMessage ?? '',
        ));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }
}
