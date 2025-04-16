import 'package:equatable/equatable.dart';

/// State for the login screen
class LoginState extends Equatable {
  /// Creates a login state
  const LoginState({
    this.welcomeMessage = 'Welcome to EIGA!',
  });

  /// Creates the initial login state
  factory LoginState.initial() => const LoginState();

  /// The welcome message to display
  final String welcomeMessage;

  /// Creates a copy of this state with the given fields replaced
  LoginState copyWith({
    String? welcomeMessage,
  }) {
    return LoginState(
      welcomeMessage: welcomeMessage ?? this.welcomeMessage,
    );
  }

  @override
  List<Object?> get props => [welcomeMessage];
}
