part of'change_password_bloc.dart';

enum ChangePasswordStatus { initial, loading,success, error, fail}

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.errorMessage = '',
  });
  final ChangePasswordStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}