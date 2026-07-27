import 'dart:ui'; // Required for ImageFilter
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/chat_screen.dart';
import 'package:fitness/features/exercise/presentation/pages/home_screen.dart';
import 'package:fitness/features/profile/presentation/pages/profile_screen.dart';
import 'package:fitness/features/exercise/presentation/pages/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/di/di.dart';
import '../../features/exercise/presentation/manager/muscles_cubit/muscles_cubit.dart';
import '../shared_widgets/svg_wrapper.dart';
import '../utils/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int currentIndex;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    screens = [
      const HomeScreen(),
      const ChatScreen(),
      BlocProvider(
        create: (context) => getIt<MusclesCubit>(),
        child: const WorkoutScreen(),
      ),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,

      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ), // Glass blur effect
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.darkCharcoal.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, AppAssets.homeIcon, local.explore),
                    _buildNavItem(1, AppAssets.chatIcon, local.smartCoach),
                    _buildNavItem(2, AppAssets.workoutIcon, local.workouts),
                    _buildNavItem(3, AppAssets.personIcon, local.profile),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String assetPath, String label) {
    final isSelected = currentIndex == index;
    const activeColor = AppColors.main;
    const inactiveColor = AppColors.white;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (currentIndex == index) return;
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _BottomNavIcon(
              path: assetPath,
              isSelected: isSelected,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: activeColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  const _BottomNavIcon({
    required this.path,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
  });

  final String path;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return SvgWrapper(
      path: path,
      width: 24,
      height: 24,
      color: isSelected ? activeColor : inactiveColor,
    );
  }
}
