import '../../models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _repository;

  HomeBloc(this._repository) : super(const HomeState()) {
    on<HomeEvent>(_mapGetUserEventToState);
  }

  void _mapGetUserEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.initial));

      final User? user = await _repository.getUser();
      user != null
          ? emit(state.copyWith(status: HomeStatus.success, user: user))
          : emit(
        state.copyWith(
          status: HomeStatus.fail,
          errorMessage: 'An error occurred. Please try again',
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}