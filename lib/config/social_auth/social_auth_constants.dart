class SocialAuthConstants {
  // Google Scopes
  static const String googleEmailScope = 'email';
  static const String googleProfileScope = 'https://www.googleapis.com/auth/userinfo.profile';

  // Facebook Permissions
  static const List<String> facebookPermissions = ['public_profile', 'email'];

  // Facebook Fields
  static const String facebookFields = 'id,first_name,last_name,name,email,picture.width(500)';

  // Data Keys
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String firstNameKey = 'first_name';
  static const String lastNameKey = 'last_name';
  static const String emailKey = 'email';
  static const String pictureKey = 'picture';
  static const String dataKey = 'data';
  static const String urlKey = 'url';
}
