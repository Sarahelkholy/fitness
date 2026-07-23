import 'package:fitness/features/auth/data/models/requests/login_request.dart';

sealed class LoginEvent {}

class LoginWithApi extends LoginEvent {
  LoginWithApi(this.request);

  LoginRequest request;
}

class LoginWithGoogle extends LoginEvent {}

class LoginWithFacebook extends LoginEvent {}
