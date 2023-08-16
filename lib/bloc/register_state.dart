part of'register_bloc.dart';

enum RegisterStatus { initial, loading,success, error, fail}

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.errorMessage = '',
  });
  final RegisterStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}