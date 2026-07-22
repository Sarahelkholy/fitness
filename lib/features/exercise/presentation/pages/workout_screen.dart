import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(localizations.workouts),
      ),

    );
  }
}
