import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/features/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/profile/presentation/pages/widgets/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(local.editProfile),
      ),

      body: BlocProvider(
        create: (context) => getIt<EditProfileCubit>(),
        child: const EditProfileView(),
      ),
    );
  }
}
