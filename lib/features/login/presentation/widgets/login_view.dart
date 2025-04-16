import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ksk_app/core/sizes/app_dimension.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/login/application/cubit/login_cubit.dart';
import 'package:ksk_app/features/login/application/cubit/login_state.dart';

/// The main view for the login screen
class LoginView extends StatelessWidget {
  /// Default constructor
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimension.h24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.welcomeMessage,
                  style: AppTextStyle.headingXl(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(AppDimension.v24),
                Text(
                  'Your movie journey begins here.',
                  style: AppTextStyle.bodyLg(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
