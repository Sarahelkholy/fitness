import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/logout_cubit/logout_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<LogoutCubit>(),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loginRoute,
              (route) => false,
            );
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.darkCharcoal.withValues(alpha: 0.8),
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 28,
              vertical: 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  local.logoutDialog,
                  style: AppTextStyles.semiBold20(context),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: local.no,
                        borderColor: AppColors.main,
                        titleStyle: AppTextStyles.extraBold14(context),
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: AppColors.darkCharcoal.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(width: 30),
                    Expanded(
                      child: BlocBuilder<LogoutCubit, LogoutState>(
                        builder: (context, state) {
                          final isLoading = state is LogoutLoading;

                          return CustomButton(
                            isLoading: isLoading,
                            title: local.yes,
                            backgroundColor: AppColors.main,
                            titleStyle: AppTextStyles.extraBold14(context),
                            onPressed: () {
                              context.read<LogoutCubit>().doEvents(
                                LogoutEvent(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
