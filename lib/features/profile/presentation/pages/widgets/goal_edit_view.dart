import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/widgets/register_form/selection_list_widget.dart';
import 'package:flutter/material.dart';

class GoalEditView extends StatefulWidget {
  final String initialGoal;
  final Function(String) onGoalSaved;

  const GoalEditView({
    super.key,
    required this.initialGoal,
    required this.onGoalSaved,
  });

  @override
  State<GoalEditView> createState() => _GoalEditViewState();
}

class _GoalEditViewState extends State<GoalEditView> {
  late String _selectedGoal;

  @override
  void initState() {
    super.initState();
    _selectedGoal = widget.initialGoal;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);

    final goalOptions = [
      SelectionOption(value: 'Gain Weight', label: local.gainWeight),
      SelectionOption(value: 'Lose Weight', label: local.loseWeight),
      SelectionOption(value: 'Get Fitter', label: local.getFitted),
      SelectionOption(
        value: 'Gain More Flexible',
        label: local.gainMoreFlexible,
      ),
      SelectionOption(value: 'Learn The Basic', label: local.learnTheBasic),
    ];

    return CustomScaffold(
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          AppAssets.appLogo,
          height: 48,
          width: 70,
          fit: BoxFit.fill,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                local.whatIsYourGoal.toUpperCase(),
                style: AppTextStyles.bold20(
                  context,
                ).copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                local.thisHelpsUsCreateYourPersonalizedPlan,
                style: AppTextStyles.regular12(
                  context,
                ).copyWith(color: AppColors.grayBD),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SelectionListWidget<String>(
                selectedValue: _selectedGoal,
                options: goalOptions,
                onSelected: (value) {
                  setState(() {
                    _selectedGoal = value;
                  });
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  title: local.done,
                  onPressed: () {
                    widget.onGoalSaved(_selectedGoal);
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
