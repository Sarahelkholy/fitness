import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/local_cubit/locale_cubit.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/profile/presentation/widgets/profile/card_devider.dart';
import 'package:fitness/features/profile/presentation/widgets/profile/logout_dialog.dart';
import 'package:fitness/features/profile/presentation/widgets/profile/profile_card.dart';
import 'package:fitness/features/profile/presentation/widgets/profile/profile_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Top Bar
              Center(
                child: Text(
                  local.profile,
                  style: AppTextStyles.semiBold24(context),
                ),
              ),
              const SizedBox(height: 10),

              const ProfileUserInfo(),

              const SizedBox(height: 30),

              // Options Container
              SizedBox(
                height: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkCharcoal.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ProfileCard(
                        icon: Icons.person_outline,
                        title: local.editProfile,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.editProfileRoute);
                        },
                      ),
                      const CardDivider(),
                      ProfileCard(
                        icon: Icons.refresh,
                        title: local.changePassword,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.changPasswordRoute,
                          );
                        },
                      ),
                      const CardDivider(),
                      _buildLanguageOption(context, local),
                      const CardDivider(),
                      ProfileCard(
                        icon: Icons.settings_outlined,
                        title: local.security,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.profileSecurityRoute,
                          );
                        },
                      ),
                      const CardDivider(),
                      ProfileCard(
                        icon: Icons.shield_outlined,
                        title: local.privacyPolicy,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.profilePrivacyRoute,
                          );
                        },
                      ),
                      const CardDivider(),
                      ProfileCard(
                        icon: Icons.support_agent_outlined,
                        title: local.help,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.profileHelpRoute);
                        },
                      ),
                      const CardDivider(),
                      ProfileCard(
                        icon: Icons.logout,
                        title: local.logout,
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) =>
                                const LogoutDialog(),
                          );
                        },
                        titleStyle: AppTextStyles.semiBold16(
                          context,
                        ).copyWith(color: AppColors.main),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Language Selector Switch powered by LocaleCubit
  Widget _buildLanguageOption(BuildContext context, AppLocalizations local) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEnglish = locale.languageCode == 'en';

        return ListTile(
          leading: const Icon(Icons.language, color: AppColors.main, size: 22),
          title: RichText(
            text: TextSpan(
              text: '${local.selectLanguage} (',
              style: AppTextStyles.semiBold16(context),
              children: [
                TextSpan(
                  text: isEnglish ? local.english : local.arabic,
                  style: AppTextStyles.semiBold16(
                    context,
                  ).copyWith(color: AppColors.main),
                ),
                const TextSpan(text: ')'),
              ],
            ),
          ),
          trailing: Switch(
            value: isEnglish,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.main,
            onChanged: (_) {
              context.read<LocaleCubit>().toggleLanguage();
            },
          ),
        );
      },
    );
  }
}
