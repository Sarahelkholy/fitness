import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class UpcomingFeatureScreen extends StatelessWidget {
  const UpcomingFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppAssets.exercisesBackground,

      body: Center(
        child: Text('Upcoming feature', style: AppTextStyles.medium18(context)),
      ),
    );
  }
}
