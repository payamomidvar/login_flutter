import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/login.dart';
import 'package:login/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _repository;

  LoginBloc(this._repository) : super(const LoginState()) {
    on<LoginEvent>(_mapLoginEventToState);
  }

  void _mapLoginEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.initial));

      final bool result = await _repository.login(event.dto);
      result
          ? emit(state.copyWith(status: LoginStatus.success))
          : emit(
        state.copyWith(
          status: LoginStatus.fail,
          errorMessage: 'An error occurred. Please try again',
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
