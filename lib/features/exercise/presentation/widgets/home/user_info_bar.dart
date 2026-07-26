import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/config/user/manager/user_events.dart';
import 'package:fitness/config/user/manager/user_state.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/shimmer/user_info_bar_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoBar extends StatefulWidget {
  const UserInfoBar({super.key});

  @override
  State<UserInfoBar> createState() => _UserInfoBarState();
}

class _UserInfoBarState extends State<UserInfoBar> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().doEvent(GetUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const UserInfoBarShimmer();
        }

        final firstName = state.user?.firstName ?? '';
        final userPhoto = state.user?.photo;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${local.hi} $firstName,',
                  style: AppTextStyles.medium16(context),
                ),
                Text(
                  local.startYourDay,
                  style: AppTextStyles.medium18(context),
                ),
              ],
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: userPhoto != null && userPhoto.isNotEmpty
                  ? NetworkImage(userPhoto) as ImageProvider
                  : const AssetImage(AppAssets.userTestImage),
            ),
          ],
        );
      },
    );
  }
}
