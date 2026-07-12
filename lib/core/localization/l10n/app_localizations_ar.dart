// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get cubit => 'كيوبت';

  @override
  String get emptyField => 'لا يمكن أن يكون هذا الحقل فارغًا';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get passwordValid =>
      'يجب أن تحتوي كلمة المرور على حرف كبير وحرف صغير ورقم ورمز خاص';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور جديدة';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get phoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get phoneInvalid => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get pageNotFound => 'الصفحة غير موجودة';

  @override
  String get sessionExpired => 'انتهت الجلسة';

  @override
  String get pleaseLoginAgain => 'يرجى تسجيل الدخول مرة أخرى';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get connectionTimeoutMessage =>
      'انتهت مهلة الاتصال.\nيرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.';

  @override
  String get sendTimeoutMessage =>
      'استغرق إرسال الطلب وقتًا أطول من المتوقع.\nيرجى المحاولة مرة أخرى.';

  @override
  String get receiveTimeoutMessage =>
      'استغرق الخادم وقتًا طويلًا للاستجابة.\nيرجى المحاولة لاحقًا.';

  @override
  String get badCertificateMessage =>
      'حدث خطأ في شهادة الأمان.\nيرجى المحاولة لاحقًا.';

  @override
  String get requestCancelledMessage => 'تم إلغاء الطلب.';

  @override
  String get connectionErrorMessage =>
      'لا يوجد اتصال بالإنترنت.\nيرجى التحقق من الشبكة.';

  @override
  String get unknownErrorMessage => 'حدث خطأ ما.\nيرجى المحاولة مرة أخرى.';

  @override
  String get unexpectedErrorMessage =>
      'حدث خطأ غير متوقع.\nيرجى المحاولة مرة أخرى.';

  @override
  String get error400 => 'طلب غير صالح';

  @override
  String get error401 => 'غير مصرح بالوصول';

  @override
  String get error403 => 'ممنوع';

  @override
  String get error404 => 'غير موجود';

  @override
  String get error408 => 'انتهت مهلة الطلب';

  @override
  String get error429 => 'عدد كبير جدًا من الطلبات';

  @override
  String get error500 => 'خطأ داخلي في الخادم';

  @override
  String get error502 => 'بوابة غير صالحة';

  @override
  String get error503 => 'الخدمة غير متاحة';

  @override
  String get error504 => 'انتهت مهلة البوابة';

  @override
  String get defaultError => 'حدث خطأ ما';
}
