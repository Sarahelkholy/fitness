abstract class ApiEndPoints {
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1";
  static const String mealsBaseUrl = "https://www.themealdb.com/api/json/v1/1";

  static const String getUserData = "/auth/profile-data";
  static const String editProfile = "/auth/editProfile";
  static const String login = "/auth/signin";
  static const String register = "/auth/signup";
  static const String logout = "/auth/logout";

  static const String fcmBaseUrl = 'https://fcm.googleapis.com';
  static const String fcmSendPath = '/v1/projects/{projectId}/messages:send';

  static const String forgetPassword = '/auth/forgotPassword';
  static const String verifyRestOtp = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";

  static const String randomExercises = "/muscles/random";

  ///? ================== Get All Muscles Group =================
  static const String getAllMusclesGroup = "/muscles";

  ///? ================ Get Muscles Group using id
  static const String exercisesByMuscleDifficulty =
      "/exercises/by-muscle-difficulty";
  static const String difficultyLevels =
      "/levels/difficulty-levels/by-prime-mover";
  static const String getMuscleGroupId = "/musclesGroup";

  static const String getMealsCategories = "/categories.php";
  static const String getMealsByCategory = "/filter.php";
  static const String getMealDetails = "/lookup.php";

  static const String getRandomPrimeMoverMusclesEndpoint = '/exercises/random';
  static const String uploadPhoto = "/auth/upload-photo";
}
