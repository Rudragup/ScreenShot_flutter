import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class OTPLoading extends LoginState {}

class OTPVerified extends LoginState {}

class OTPError extends LoginState {
  final String message;
  final int wrongAttempts;

  const OTPError({required this.message, required this.wrongAttempts});

  @override
  List<Object?> get props => [message, wrongAttempts];
}

class OTPBlocked extends LoginState {
  final String message;

  const OTPBlocked({required this.message});

  @override
  List<Object?> get props => [message];
}
