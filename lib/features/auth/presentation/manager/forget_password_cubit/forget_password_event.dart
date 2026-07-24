sealed class ForgetPasswordEvents {}

class SendEmailEvent extends ForgetPasswordEvents {
  final String? email;

  SendEmailEvent({this.email});
}

class VerifyOtpEvent extends ForgetPasswordEvents {
  final String? otp;

  VerifyOtpEvent({this.otp});
}

class ResendOtpEvent extends ForgetPasswordEvents {
  final String? email;

  ResendOtpEvent({this.email});
}

class ResetPasswordEvent extends ForgetPasswordEvents {
  final String? email;
  final String? newPassword;

  ResetPasswordEvent({this.newPassword, this.email});
}
