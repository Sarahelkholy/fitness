import 'package:fitness/core/helpers/event_handler_mixin.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_event.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_state.dart';
import 'package:fitness/features/auth/presentation/widgets/register_form/circular_step_progress.dart';
import 'package:fitness/features/auth/presentation/widgets/register_form/gender_selection_widget.dart';
import 'package:fitness/features/auth/presentation/widgets/register_form/number_picker_widget.dart';
import 'package:fitness/features/auth/presentation/widgets/register_form/selection_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../domain/entities/register_form_data.dart';
import '../../widgets/register_form/register_step_layout.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen>
    with EventHandlerMixin {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 6;

  late AppLocalizations localizations;
  late final RegisterFormCubit _cubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _cubit = context.read<RegisterFormCubit>();

    _cubit.eventStream.listen((event) {
      if (!mounted) return;
      handleEvent(event);
    });
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _cubit.doEvents(SubmitRegisterFormEvent());
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _isNextEnabled(RegisterFormState state) {
    final data = state.formData;
    switch (_currentPage) {
      case 0:
        return data.gender != null;
      case 1:
        return data.age != null;
      case 2:
        return data.weight != null;
      case 3:
        return data.height != null;
      case 4:
        return data.goal != null;
      case 5:
        return data.activityLevel != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _previousPage();
      },
      child: CustomScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const CircleAvatar(
              backgroundColor: AppColors.main,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: AppColors.white,
              ),
            ),
            onPressed: () {
              if (_currentPage > 0) {
                _previousPage();
              }
              // Removed Navigator.pop(context) to prevent popping from first page
            },
          ),
          title: Image.asset(
            AppAssets.appLogo,
            height: 48,
            width: 70,
            fit: BoxFit.fill,
          ),
        ),
        body: BlocBuilder<RegisterFormCubit, RegisterFormState>(
          builder: (context, state) {
            final bool isEnabled = _isNextEnabled(state);
            return Column(
              children: [
                const SizedBox(height: 50),
                CircularStepProgress(
                  currentStep: _currentPage + 1,
                  totalSteps: _totalPages,
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      // Step 1: Gender
                      RegisterStepLayout(
                        buttonKey: Key(KeysStrings.registerFormNextButtonStep1),
                        title: localizations.tellUsAboutYourself,
                        subtitle: localizations.weNeedToKnowYourGender,
                        buttonText: localizations.next,
                        onButtonPressed: isEnabled ? _nextPage : null,
                        content: GenderSelectionWidget(
                          selectedGender: state.formData.gender,
                          onGenderSelected: (gender) {
                            _cubit.doEvents(PickGenderEvent(gender: gender));
                          },
                        ),
                      ),

                      // Step 2: Age
                      RegisterStepLayout(
                        buttonKey: Key(KeysStrings.registerFormNextButtonStep2),
                        title: localizations.howOldAreYou,
                        subtitle:
                            localizations.thisHelpsUsCreateYourPersonalizedPlan,
                        buttonText: localizations.next,
                        onButtonPressed: isEnabled ? _nextPage : null,
                        content: NumberPickerWidget(
                          initialValue: state.formData.age ?? 25,
                          min: 10,
                          max: 100,
                          unit: localizations.year,
                          onValueChanged: (age) {
                            _cubit.doEvents(PickAgeEvent(age: age));
                          },
                        ),
                      ),

                      // Step 3: Weight
                      RegisterStepLayout(
                        buttonKey: Key(KeysStrings.registerFormNextButtonStep3),
                        title: localizations.whatIsYourWeight,
                        subtitle:
                            localizations.thisHelpsUsCreateYourPersonalizedPlan,
                        buttonText: localizations.next,
                        onButtonPressed: isEnabled ? _nextPage : null,
                        content: NumberPickerWidget(
                          initialValue: state.formData.weight ?? 70,
                          min: 30,
                          max: 200,
                          unit: localizations.kg,
                          onValueChanged: (weight) {
                            _cubit.doEvents(PickWeightEvent(weight: weight));
                          },
                        ),
                      ),

                      // Step 4: Height
                      RegisterStepLayout(
                        buttonKey: Key(KeysStrings.registerFormNextButtonStep4),
                        title: localizations.whatIsYourHeight,
                        subtitle:
                            localizations.thisHelpsUsCreateYourPersonalizedPlan,
                        buttonText: localizations.next,
                        onButtonPressed: isEnabled ? _nextPage : null,
                        content: NumberPickerWidget(
                          initialValue: state.formData.height ?? 170,
                          min: 100,
                          max: 250,
                          unit: localizations.cm,
                          onValueChanged: (height) {
                            _cubit.doEvents(PickHeightEvent(height: height));
                          },
                        ),
                      ),

                      // Step 5: Goal
                      RegisterStepLayout(
                        buttonKey: Key(KeysStrings.registerFormNextButtonStep5),
                        title: localizations.whatIsYourGoal,
                        subtitle:
                            localizations.thisHelpsUsCreateYourPersonalizedPlan,
                        buttonText: localizations.next,
                        onButtonPressed: isEnabled ? _nextPage : null,
                        content: SelectionListWidget<UserGoal>(
                          selectedValue: state.formData.goal,
                          options: [
                            SelectionOption(
                              value: UserGoal.loseWeight,
                              label: localizations.loseWeight,
                            ),
                            SelectionOption(
                              value: UserGoal.gainWeight,
                              label: localizations.gainWeight,
                            ),
                            SelectionOption(
                              value: UserGoal.getFitter,
                              label: localizations.getFitted,
                            ),
                            SelectionOption(
                              value: UserGoal.gainMoreFlexible,
                              label: localizations.gainMoreFlexible,
                            ),
                            SelectionOption(
                              value: UserGoal.learnTheBasic,
                              label: localizations.learnTheBasic,
                            ),
                          ],
                          onSelected: (goal) {
                            _cubit.doEvents(PickGoalEvent(goal: goal));
                          },
                        ),
                      ),

                      // Step 6: Activity Level
                      RegisterStepLayout(
                        buttonKey: Key(KeysStrings.registerFormNextButtonStep6),
                        title: localizations.yourRegularPhysicalActivityLevel,
                        subtitle:
                            localizations.thisHelpsUsCreateYourPersonalizedPlan,
                        buttonText: localizations.done,
                        isLoading: state.updateUserState.isLoading,
                        onButtonPressed: isEnabled ? _nextPage : null,
                        content: SelectionListWidget<ActivityLevel>(
                          selectedValue: state.formData.activityLevel,
                          options: [
                            SelectionOption(
                              value: ActivityLevel.level1,
                              label: localizations.level1,
                            ),
                            SelectionOption(
                              value: ActivityLevel.level2,
                              label: localizations.level2,
                            ),
                            SelectionOption(
                              value: ActivityLevel.level3,
                              label: localizations.level3,
                            ),
                            SelectionOption(
                              value: ActivityLevel.level4,
                              label: localizations.level4,
                            ),
                            SelectionOption(
                              value: ActivityLevel.level5,
                              label: localizations.level5,
                            ),
                          ],
                          onSelected: (level) {
                            _cubit.doEvents(
                              PickActivityLevelEvent(activityLevel: level),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
