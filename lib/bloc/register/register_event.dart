part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent(this.dto);

  final Register dto;

  @override
  List<Object?> get props => [dto];
}