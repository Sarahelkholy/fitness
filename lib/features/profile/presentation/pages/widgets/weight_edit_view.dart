import 'package:fitness/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class WeightEditView extends StatefulWidget {
  final num initialWeight;
  final Function(int) onWeightSaved;

  const WeightEditView({
    super.key,
    required this.initialWeight,
    required this.onWeightSaved,
  });

  @override
  State<WeightEditView> createState() => _WeightEditViewState();
}

class _WeightEditViewState extends State<WeightEditView> {
  final PageController _pageController = PageController(initialPage: 40);
  int _selectedWeight = 40;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "WHAT IS YOUR WEIGHT ?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "This Helps Us Create Your Personalized Plan",
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
        const SizedBox(height: 40),

        // Weight Display
        Stack(
          alignment: Alignment.center,
          children: [
            // Center line indicator
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                color: Colors.white.withOpacity(0.2),
                margin: const EdgeInsets.only(bottom: 45),
              ),
            ),
            SizedBox(
              height: 120,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                physics: const FixedExtentScrollPhysics(),
                itemCount: 200,
                itemBuilder: (context, index) {
                  final weight = index + 1;
                  return Center(
                    child: AnimatedScale(
                      scale: weight == _selectedWeight ? 1.0 : 0.7,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        weight.toString(),
                        style: TextStyle(
                          fontSize: weight == _selectedWeight ? 64 : 40,
                          fontWeight: weight == _selectedWeight
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: weight == _selectedWeight
                              ? Colors.white
                              : Colors.white24,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Gradient overlay to fade top/bottom
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.0, 0.4, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          "kg",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const Spacer(),

        // Custom Number Picker
        // CustomNumberPicker(
        //   initialValue: _selectedWeight,
        //   min: 1,
        //   max: 200,
        //   onChanged: (value) {
        //     setState(() {
        //       _selectedWeight = value;
        //     });
        //     _pageController.animateToPage(
        //       value - 1,
        //       duration: const Duration(milliseconds: 500),
        //       curve: Curves.easeOut,
        //     );
        //   },
        //   itemHeight: 70,
        //   diameterRatio: 2.0,
        //   perspective: 0.003,
        // ),
        const SizedBox(height: 32),

        // Next Button
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const LinearGradient(
              colors: [AppColors.main, AppColors.darkMaroon70],
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Handle next action
              print("Selected weight: $_selectedWeight");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
