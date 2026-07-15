// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cubit => 'Cubit';

  @override
  String get emptyField => 'This field cannot be empty';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgetPassword => 'Forget Password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordValid =>
      'Password must contain uppercase, lowercase, number, and special character';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneInvalid => 'Please enter a valid phone number';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get sessionExpired => 'Session Expired';

  @override
  String get pleaseLoginAgain => 'Please Login Again';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get login => 'Login';

  @override
  String get connectionTimeoutMessage =>
      'Connection timeout.\nPlease check your internet connection and try again.';

  @override
  String get sendTimeoutMessage =>
      'Request took too long to send.\nPlease try again.';

  @override
  String get receiveTimeoutMessage =>
      'Server took too long to respond.\nPlease try again later.';

  @override
  String get badCertificateMessage =>
      'Security certificate error.\nPlease try again later.';

  @override
  String get requestCancelledMessage => 'Request was cancelled.';

  @override
  String get connectionErrorMessage =>
      'No internet connection.\nPlease check your network.';

  @override
  String get unknownErrorMessage => 'Something went wrong.\nPlease try again.';

  @override
  String get unexpectedErrorMessage =>
      'Unexpected error occurred.\nPlease try again.';

  @override
  String get error400 => 'Bad Request';

  @override
  String get error401 => 'Unauthorized';

  @override
  String get error403 => 'Forbidden';

  @override
  String get error404 => 'Not Found';

  @override
  String get error408 => 'Request Timeout';

  @override
  String get error429 => 'Too Many Requests';

  @override
  String get error500 => 'Internal Server Error';

  @override
  String get error502 => 'Bad Gateway';

  @override
  String get error503 => 'Service Unavailable';

  @override
  String get error504 => 'Gateway Timeout';

  @override
  String get defaultError => 'An error occurred';

  @override
  String get explore => 'Explore';

  @override
  String get smartCoach => 'Smart coach';

  @override
  String get workouts => 'Workouts';

  @override
  String get profile => 'Profile';
}
