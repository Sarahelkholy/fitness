import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: ValueKey(selectedIndex),
      length: tabs.length,
      initialIndex: selectedIndex,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        onTap: onTabChanged,
        indicator: BoxDecoration(
          color: AppColors.main,
          borderRadius: BorderRadius.circular(20),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.white,
        labelStyle: AppTextStyles.bold12(context),
        unselectedLabelStyle: AppTextStyles.bold12(context),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}
