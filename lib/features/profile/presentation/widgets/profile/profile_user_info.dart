import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/config/user/manager/user_events.dart';
import 'package:fitness/config/user/manager/user_state.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUserInfo extends StatefulWidget {
  const ProfileUserInfo({super.key});

  @override
  State<ProfileUserInfo> createState() => _ProfileUserInfoState();
}

class _ProfileUserInfoState extends State<ProfileUserInfo> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().doEvent(GetUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CustomLoadingIndicator();
        }

        final firstName = state.user?.firstName ?? '';
        final lastName = state.user?.lastName ?? '';
        final name = '$firstName $lastName'.trim();
        final userPhoto = state.user?.photo;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: userPhoto != null && userPhoto.isNotEmpty
                  ? NetworkImage(userPhoto) as ImageProvider
                  : const AssetImage(AppAssets.userTestImage),
            ),
            const SizedBox(height: 16),

            // User Name
            Text(name, style: AppTextStyles.semiBold20(context)),
          ],
        );
      },
    );
  }
}
