import 'package:flutter/material.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/utils/app_colors.dart';

class WeightEditView extends StatefulWidget {
  final int selectedWeight;
  final ValueChanged<int> onNext;

  const WeightEditView({
    super.key,
    required this.selectedWeight,
    required this.onNext,
  });

  @override
  State<WeightEditView> createState() => _WeightEditViewState();
}

class _WeightEditViewState extends State<WeightEditView> {
  static const int minWeight = 1;
  static const int maxWeight = 200;

  late final PageController _pageController;

  late int currentWeight;

  @override
  void initState() {
    super.initState();

    currentWeight = widget.selectedWeight;

    _pageController = PageController(
      viewportFraction: 0.25,
      initialPage: currentWeight - minWeight,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return CustomScaffold(
      body: Column(
        children: [
          const Spacer(),

          const Text(
            "WHAT IS YOUR WEIGHT ?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "This Helps Us Create Your Personalized Plan",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),

          SizedBox(height: height * .05),

          const Text(
            "Kg",
            style: TextStyle(
              color: AppColors.main,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: height * .02),

          SizedBox(
            height: 90,

            child: Stack(
              alignment: Alignment.center,

              children: [
                // Container(height: 1, color: Colors.white24),
                PageView.builder(
                  controller: _pageController,

                  itemCount: maxWeight - minWeight + 1,

                  physics: const BouncingScrollPhysics(),

                  onPageChanged: (index) {
                    setState(() {
                      currentWeight = index + minWeight;
                    });
                  },

                  itemBuilder: (context, index) {
                    final weight = index + minWeight;

                    final distance = (currentWeight - weight).abs();

                    return AnimatedScale(
                      scale: distance == 0
                          ? 1
                          : distance == 1
                          ? .75
                          : .55,

                      duration: const Duration(milliseconds: 200),

                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),

                          style: TextStyle(
                            fontSize: distance == 0 ? 42 : 22,

                            fontWeight: FontWeight.w800,

                            color: distance == 0
                                ? AppColors.main
                                : Colors.white38,
                          ),

                          child: Text("$weight"),
                        ),
                      ),
                    );
                  },
                ),

                const Positioned(
                  bottom: -5,

                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 38,
                    color: AppColors.main,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .08),

            child: SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  widget.onNext(currentWeight);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main,

                  padding: const EdgeInsets.symmetric(vertical: 16),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),

                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: height * .04),
        ],
      ),
    );
  }
}
