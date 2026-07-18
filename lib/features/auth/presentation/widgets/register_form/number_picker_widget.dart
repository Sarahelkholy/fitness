import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class NumberPickerWidget extends StatefulWidget {
  final num initialValue;
  final num min;
  final num max;
  final String unit;
  final Function(num) onValueChanged;

  const NumberPickerWidget({
    super.key,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.unit,
    required this.onValueChanged,
  });

  @override
  State<NumberPickerWidget> createState() => _NumberPickerWidgetState();
}

class _NumberPickerWidgetState extends State<NumberPickerWidget> {
  late FixedExtentScrollController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = (widget.initialValue - widget.min).toInt();
    _controller = FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.unit,
          style: AppTextStyles.regular14(
            context,
          ).copyWith(color: AppColors.main),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: RotatedBox(
            quarterTurns: -1,
            child: ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: 80,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onValueChanged(widget.min + index);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final value = widget.min + index;
                  final isSelected = index == _selectedIndex;
                  return RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child: Text(
                        "$value",
                        style: isSelected
                            ? AppTextStyles.extraBold44(
                                context,
                              ).copyWith(color: AppColors.main)
                            : AppTextStyles.extraBold33(
                                context,
                              ).copyWith(color: AppColors.white),
                      ),
                    ),
                  );
                },
                childCount: (widget.max - widget.min + 1).toInt(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Icon(Icons.arrow_drop_up, color: AppColors.main, size: 40),
      ],
    );
  }
}
