import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/widgets/register_form/selection_list_widget.dart';
import 'package:flutter/material.dart';

class ActivityEditView extends StatefulWidget {
  final String initialActivity;
  final Function(String) onActivitySaved;

  const ActivityEditView({
    super.key,
    required this.initialActivity,
    required this.onActivitySaved,
  });

  @override
  State<ActivityEditView> createState() => _ActivityEditViewState();
}

class _ActivityEditViewState extends State<ActivityEditView> {
  late String _selectedActivity;

  @override
  void initState() {
    super.initState();
    _selectedActivity = widget.initialActivity;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);

    final activityOptions = [
      SelectionOption(value: 'Rookie', label: local.level1),
      SelectionOption(value: 'Beginner', label: local.level2),
      SelectionOption(value: 'Intermediate', label: local.level3),
      SelectionOption(value: 'Advance', label: local.level4),
      SelectionOption(value: 'True Beast', label: local.level5),
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
                local.yourRegularPhysicalActivityLevel.toUpperCase(),
                style: AppTextStyles.bold20(context).copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SelectionListWidget<String>(
                selectedValue: _selectedActivity,
                options: activityOptions,
                onSelected: (value) {
                  setState(() {
                    _selectedActivity = value;
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
                    widget.onActivitySaved(_selectedActivity);
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
