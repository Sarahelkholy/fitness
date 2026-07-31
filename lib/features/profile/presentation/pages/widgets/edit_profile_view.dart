import 'dart:io';
import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/config/user/manager/user_events.dart';
import 'package:fitness/config/user/manager/user_state.dart';
import 'package:fitness/core/helpers/app_snack_bar.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/shared_widgets/glass_container.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:fitness/features/profile/api/data_sources/models/request/edit_profile_request.dart';
import 'package:fitness/features/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/profile/presentation/pages/widgets/weight_edit_view.dart';
import 'package:fitness/features/profile/presentation/pages/widgets/goal_edit_view.dart';
import 'package:fitness/features/profile/presentation/pages/widgets/activity_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _weightController;
  late TextEditingController _goalController;
  late TextEditingController _activityLevelController;

  num? _selectedWeight;
  String? _selectedGoal;
  String? _selectedActivityLevel;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state.user;
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');

    _selectedWeight = user?.weight;
    _selectedGoal = user?.goal;
    _selectedActivityLevel = user?.activityLevel;

    // Initialize with empty text; actual label will be set in didChangeDependencies
    _activityLevelController = TextEditingController();
    _weightController = TextEditingController(
      text: _selectedWeight != null ? '$_selectedWeight KG' : '',
    );
    _goalController = TextEditingController(text: _selectedGoal ?? '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final local = AppLocalizations.of(context)!;
    // Set the activity level label based on the current selected level
    _activityLevelController.text = getActivityLabel(
      _selectedActivityLevel,
      local,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    _activityLevelController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null && mounted) {
      context.read<EditProfileCubit>().doIntents(
        OnUploadPhotoPressed(File(image.path)),
      );
    }
  }

  void _navigateToWeightEdit() {
    final user = context.read<UserCubit>().state.user;
    final initialWeight =
        _selectedWeight?.toInt() ?? user?.weight.toInt() ?? 90;
    final controller = PageController(initialPage: initialWeight - 1);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeightEditView(
          selectedWeight: initialWeight,
          // pageController: controller,
          onNext: (value) {
            setState(() {
              _selectedWeight = value;
              _weightController.text = '$value KG';
            });
            Navigator.pop(context);
          },
        ),
      ),
    ).then((_) {
      controller.dispose();
    });
  }

  void _navigateToGoalEdit(String? goal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalEditView(
          initialGoal: goal ?? _selectedGoal ?? '',
          onGoalSaved: (value) {
            setState(() {
              _selectedGoal = value;
              _goalController.text = value;
            });
          },
        ),
      ),
    );
  }

  String getActivityLabel(String? level, AppLocalizations local) {
    switch (level) {
      case "level1":
        return local.level1;

      case "level2":
        return local.level2;

      case "level3":
        return local.level3;

      case "level4":
        return local.level4;

      case "level5":
        return local.level5;

      default:
        return "";
    }
  }

  void _navigateToActivityEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityEditView(
          initialActivity: _selectedActivityLevel,
          onActivitySaved: (value) {
            setState(() {
              _selectedActivityLevel = value;

              _activityLevelController.text = getActivityLabel(
                value,
                AppLocalizations.of(context)!,
              );
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.editProfileState.isSuccess) {
          AppSnackBar.success(context, local.profileUpdatedSuccessfully);
          context.read<UserCubit>().doEvent(GetUserDataEvent());
        } else if (state.editProfileState.errorMessage != null) {
          AppSnackBar.error(context, state.editProfileState.errorMessage!);
        }

        if (state.updateUserDataState.isSuccess) {
          AppSnackBar.success(context, local.profileUpdatedSuccessfully);
          context.read<UserCubit>().doEvent(GetUserDataEvent());
        } else if (state.updateUserDataState.errorMessage != null) {
          AppSnackBar.error(context, state.updateUserDataState.errorMessage!);
        }

        if (state.uploadPhotoState.isSuccess) {
          AppSnackBar.success(context, local.photoUpdatedSuccessfully);
          context.read<UserCubit>().doEvent(GetUserDataEvent());
        } else if (state.uploadPhotoState.errorMessage != null) {
          AppSnackBar.error(context, state.uploadPhotoState.errorMessage!);
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          final user = userState.user;
          final userPhoto = user?.photo;
          final displayName =
              '${user?.firstName ?? ''} ${user?.lastName ?? ''}';

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: BorderRadius.circular(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.main,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 54,
                              backgroundImage:
                                  userPhoto != null && userPhoto.isNotEmpty
                                  ? NetworkImage(userPhoto) as ImageProvider
                                  : const AssetImage(AppAssets.userTestImage),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickAndUploadImage,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.darkCharcoal,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: AppColors.main,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // User Display Name
                      Text(
                        displayName,
                        style: AppTextStyles.bold18(
                          context,
                        ).copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // First Name Field
                      _buildTextField(
                        controller: _firstNameController,
                        hint: local.firstName,
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      // Last Name Field
                      _buildTextField(
                        controller: _lastNameController,
                        hint: local.lastName,
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      // Email Field (Read only to match typical profile views, editable if requested)
                      _buildTextField(
                        controller:
                            _emailController, // Fixed: pass controller instead of text
                        hint: local.email,
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      // Weight Field Section (Tap to Edit)
                      _buildLabeledSection(
                        label: local.yourWeight,
                        local: local,
                        child: GestureDetector(
                          onTap: _navigateToWeightEdit,
                          child: AbsorbPointer(
                            child: _buildTextField(
                              controller: _weightController,
                              hint: local.kG,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Goal Field Section (Tap to Edit)
                      _buildLabeledSection(
                        label: local.yourGoal,
                        local: local,
                        child: GestureDetector(
                          onTap: () => _navigateToGoalEdit(_selectedGoal),
                          child: AbsorbPointer(
                            child: _buildTextField(
                              controller: _goalController,
                              hint: local.weightGoal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Activity Level Field Section (Tap to Edit)
                      _buildLabeledSection(
                        label: local.yourActivityLevel,
                        local: local,
                        child: GestureDetector(
                          onTap: _navigateToActivityEdit,
                          child: AbsorbPointer(
                            child: _buildTextField(
                              controller: _activityLevelController,
                              hint: local.activityLevel,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Save Button
                      BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, editState) {
                          final isLoading =
                              editState.editProfileState.isLoading ||
                              editState.updateUserDataState.isLoading;

                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(
                              title: local.done,
                              isLoading: isLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<EditProfileCubit>().doIntents(
                                    OnEditProfilePressed(
                                      EditProfileRequest(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        email: _emailController.text,
                                        gender: user?.gender,
                                        height: user?.height.toDouble(),
                                        weight:
                                            (_selectedWeight ?? user?.weight)
                                                ?.toDouble(),
                                        goal: _selectedGoal ?? user?.goal,
                                        activityLevel:
                                            _selectedActivityLevel ??
                                            user?.activityLevel,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabeledSection({
    required String label,
    required AppLocalizations local,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Text(
                label,
                style: AppTextStyles.bold14(
                  context,
                ).copyWith(color: AppColors.white),
              ),
              const SizedBox(width: 4),
              Text(
                '(${local.tapToEdit})',
                style: AppTextStyles.bold12(
                  context,
                ).copyWith(color: AppColors.main),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    TextInputType? keyboardType,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: AppTextStyles.regular16(context).copyWith(color: AppColors.white),
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.white.withValues(alpha: 0.6))
            : null,
        hintText: hint,
        hintStyle: AppTextStyles.regular14(
          context,
        ).copyWith(color: AppColors.white.withValues(alpha: 0.4)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        filled: true,
        fillColor: AppColors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.main),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppLocalizations.of(context)!.emptyField;
        }
        return null;
      },
    );
  }
}
