import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/account/account_state.dart';

class AccountCubit extends Cubit<AccountState> {
	AccountCubit() : super(AccountState(isLoading: true));
	
	Future<void> loadInitialData() async {
		final stableState = state;
		try {
		  emit(state.copyWith(isLoading: true));
	
		  // TODO your code here
	
		  emit(state.copyWith(isLoading: false));
		} catch (error) {
		  emit(state.copyWith(error: error.toString()));
		  emit(stableState.copyWith(isLoading: false));
		}
	}
}
