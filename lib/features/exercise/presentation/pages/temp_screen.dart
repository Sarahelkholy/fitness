import 'package:flutter/material.dart';

import '../../../../config/route_manager/routes.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temp Navigation Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.exerciseRoute,
              arguments: {'primeMoverMuscleId': '69d982ef85f6bfa972bf2248'}, // Provided workoutId
            );
          },
          child: const Text('Go to Exercise Screen'),
        ),
      ),
    );
  }
}
