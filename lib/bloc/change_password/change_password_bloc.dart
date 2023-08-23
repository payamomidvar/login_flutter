import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repository.dart';
import '../../../models/change_password.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository _repository;

  ChangePasswordBloc(this._repository) : super(const ChangePasswordState()) {
    on<ChangePasswordEvent>(_mapRegisterEventToState);
  }

  void _mapRegisterEventToState(
      ChangePasswordEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(state.copyWith(status: ChangePasswordStatus.initial));

      final bool result = await _repository.changePassword(event.dto);
      result
          ? emit(state.copyWith(status: ChangePasswordStatus.success))
          : emit(
              state.copyWith(
                status: ChangePasswordStatus.fail,
                errorMessage: 'An error occurred. Please try again',
              ),
            );
    } catch (error) {
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
