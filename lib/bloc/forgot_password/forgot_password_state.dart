part of'forgot_password_bloc.dart';

enum ForgotPasswordStatus { initial, loading,success, error, fail}

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.errorMessage = '',
  });
  final ForgotPasswordStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}