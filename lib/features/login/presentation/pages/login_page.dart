import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksk_app/core/di/injection.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/login/application/cubit/login_cubit.dart';
import 'package:ksk_app/features/login/presentation/widgets/login_view.dart';

/// Login page that displays after onboarding
@RoutePage()
class LoginPage extends StatelessWidget {
  /// Default constructor
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const Scaffold(
        backgroundColor: AppColors.bgMain,
        body: SafeArea(
          child: LoginView(),
        ),
      ),
    );
  }
}
