sealed class RegisterEvents {}

class SubmitRegisterEvent extends RegisterEvents {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SubmitRegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

class GoogleRegisterEvent extends RegisterEvents {}

class FacebookRegisterEvent extends RegisterEvents {}

class SubmitPressedEvent extends RegisterEvents {}
