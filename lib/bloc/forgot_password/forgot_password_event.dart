part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent(this.dto);

  final ForgotPassword dto;

  @override
  List<Object?> get props => [dto];
}