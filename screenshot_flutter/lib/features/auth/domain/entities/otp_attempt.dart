import 'package:equatable/equatable.dart';

class OTPAttempt extends Equatable {
  final int attemptCount;
  final bool isBlocked;

  const OTPAttempt({required this.attemptCount, this.isBlocked = false});

  @override
  List<Object?> get props => [attemptCount, isBlocked];
}
