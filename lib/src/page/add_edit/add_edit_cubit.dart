import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookify/src/page/add_edit/add_edit_state.dart';

class AddEditCubit extends Cubit<AddEditState> {
	AddEditCubit() : super(AddEditState(isLoading: true));
	
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
