import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/values/keys_strings.dart';

final class OnboardingModel {
  final String image;
  final String title;
  final String desc;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  static final List<OnboardingModel> onBoardingModel = [
    const OnboardingModel(
      image: AppAssets.onBoardingScreenOne,
      title: KeysStrings.onBoardingTitle1,
      desc: KeysStrings.onBoardingDesc2,
    ),
    const OnboardingModel(
      image: AppAssets.onBoardingScreenTwo,
      title: KeysStrings.onBoardingTitle2,
      desc: KeysStrings.onBoardingDesc2,
    ),
    const OnboardingModel(
      image: AppAssets.onBoardingScreenThree,
      title: KeysStrings.onBoardingTitle3,
      desc: KeysStrings.onBoardingDesc3,
    ),
  ];
}
