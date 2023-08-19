part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent(this.dto);

  final Login dto;

  @override
  List<Object?> get props => [dto];
}
