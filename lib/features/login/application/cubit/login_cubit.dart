import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/features/login/application/cubit/login_state.dart';

/// Cubit for managing login screen state
@injectable
class LoginCubit extends Cubit<LoginState> {
  /// Constructor with dependency injection
  LoginCubit() : super(LoginState.initial());
}
