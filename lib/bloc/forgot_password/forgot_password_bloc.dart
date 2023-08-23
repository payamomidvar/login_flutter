import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/forgot_password.dart';
import '../../repositories/user_repository.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository _repository;

  ForgotPasswordBloc(this._repository) : super(const ForgotPasswordState()) {
    on<ForgotPasswordEvent>(_mapForgotPasswordEventToState);
  }

  void _mapForgotPasswordEventToState(
      ForgotPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(state.copyWith(status: ForgotPasswordStatus.initial));

      final bool result = await _repository.forgotPassword(event.dto);
      result
          ? emit(state.copyWith(status: ForgotPasswordStatus.success))
          : emit(
              state.copyWith(
                status: ForgotPasswordStatus.fail,
                errorMessage: 'An error occurred. Please try again',
              ),
            );
    } catch (error) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
