part of 'change_password_bloc.dart';

class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent(this.dto);

  final ChangePassword dto;

  @override
  List<Object?> get props => [dto];
}