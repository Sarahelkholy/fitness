import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../config/cache/secure_cache/local_keys.dart';
import '../../../../../../config/cache/secure_cache/secure_cache_helper.dart';
import '../../../../../../core/shared_widgets/glass_container.dart';
import '../../../../../../core/shared_widgets/screen_image_background.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/values/keys_strings.dart';
import '../controller/page_view_controller.dart';
import '../model/on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _onBoardingModel = OnboardingModel.onBoardingModel;
  late final PageViewController _pageController;
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    _pageController = PageViewController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenImageBackground(
      appBar: _buildAppBar(),
      imagePath: AppAssets.onBoardingBackground,
      child: Stack(
        children: [
          _buildOnboardingImage(),
          _buildOnboardingContent()
        ],
      ),
    );
  }

  ///? App Bar Screen
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actionsPadding: const EdgeInsets.only(right: 17),
      actions: [
        ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, value, child) {
            if (value == _onBoardingModel.length - 1) {
              return SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () =>
                  _pageController.skipToLastPage(_onBoardingModel.length - 1),
              child: Text(KeysStrings.onBoardingSkip),
            );
          },
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  ///? Click button onBoarding
  Widget _buildRowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///? Back
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size.zero,
            foregroundColor: AppColors.white,
            side: BorderSide(
              color: AppColors.main,
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: _pageController.navigateToPreviousPage,
          child: Text(KeysStrings.onBoardingBack),
        ),
        ///? Next
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: _currentPage.value == _onBoardingModel.length - 1 ? () {
            SecureCacheHelper.set(LocalKeys.onBoarding, true);
            Navigator.of(context,).pushNamedAndRemoveUntil(Routes.homeRoute, (route) => false);
          } : _pageController.navigateToNextPage,
          child: ValueListenableBuilder(
            valueListenable: _currentPage,
            builder: (context, value, child) {
              if (value == _onBoardingModel.length - 1) {
                return Text(KeysStrings.onBoardingDoIt);
              }
              return Text(KeysStrings.onBoardingNext);
            },
          ),
        ),
      ],
    );
  }

  ///? title and
  Widget _buildOnboardingContent() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: GlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 31),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    _onBoardingModel[value].title,
                    style: AppTextStyles.bold24(context).copyWith(
                        height: 1.40,
                        color: AppColors.white,
                        fontWeight: FontWeight.w800
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),

                Text(
                  _onBoardingModel[value].desc,
                  style: AppTextStyles.bold16(context).copyWith(
                      height: 1.40,
                      color: AppColors.grayD3,
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),

                SizedBox(height: 24),
                _buildIndicator(),
                SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: _currentPage,
                  builder: (context, value, child) {
                    if (value == 0) {
                      return ElevatedButton(
                        onPressed: _pageController.navigateToNextPage,
                        child: Text(KeysStrings.onBoardingNext),
                      );
                    }
                    return _buildRowButtons();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ///? Slider
  Widget _buildIndicator() => Align(
    alignment: Alignment.center,
    child: SmoothPageIndicator(
      controller: _pageController.controller,
      count: _onBoardingModel.length,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        dotColor: AppColors.white,
        activeDotColor: AppColors.main,
        spacing: 10,
      ),
    ),
  );

  ///? image onBoarding
  Widget _buildOnboardingImage() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController.controller,
      onPageChanged: (value) => _currentPage.value = value,
      itemCount: _onBoardingModel.length,
      itemBuilder: (context, index) =>
          Image.asset(_onBoardingModel[index].image, height: 516),
    );
  }
}

