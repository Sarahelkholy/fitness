import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_assets.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.appLogo,
          height: 48,
          width: 70,
          fit: BoxFit.fill,
        ),
      ),
      body: Column(children: []),
    );
  }
}
