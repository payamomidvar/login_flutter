import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';
import '../models/register.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _repository;

  RegisterBloc(this._repository) : super(const RegisterState()) {
    on<RegisterEvent>(_mapRegisterEventToState);
  }

  void _mapRegisterEventToState(
      RegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: RegisterStatus.initial));

      final bool result = await _repository.register(event.dto);
      result
          ? emit(state.copyWith(status: RegisterStatus.success))
          : emit(
              state.copyWith(
                status: RegisterStatus.fail,
                errorMessage: 'An error occurred. Please try again',
              ),
            );
    } catch (error) {
      emit(state.copyWith(
        status: RegisterStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
