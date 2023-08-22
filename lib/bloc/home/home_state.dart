part of'home_bloc.dart';


enum HomeStatus { initial, loading,success, error, fail}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.errorMessage = '',
    this.user,
  });
  final HomeStatus status;
  final String errorMessage;
  final User? user;

  @override
  List<Object?> get props => [status, errorMessage, user];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    User? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}