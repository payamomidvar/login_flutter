part of 'login_bloc.dart';

enum LoginStatus { initial, loading,success, error, fail}

class LoginState extends Equatable{
  LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage = '',
    this.token,
});

  final LoginStatus status;
  final String errorMessage;
  String? token;

  @override
  List<Object?> get props => [status, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? token,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      token: token
    );
  }
}