import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/repositories/user_repository.dart';

part 'signup_screen_state.dart';

class SignupScreenCubit extends Cubit<SignupScreenState> {
  final UserRepository _userRepository;

  SignupScreenCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const SignupScreenInitial());

  void onSignupDataChanged(String email, String password) {
    bool hasValidData = EmailValidator.validate(email) && password.isNotEmpty;

    emit(SignupDataChanged(
      allowSignup: hasValidData,
    ));
  }

  Future<void> onSignupButtonClicked(String email, String password) async {
    emit(const SignupInProgress());
    Either<Failure, UserCredential> result = await _userRepository.signup(
      email: email,
      password: password,
    );

    result.fold(
      (error) => emit(SignupError(
        failure: error,
      )),
      (data) => emit(const SignupSuccess()),
    );
  }
}
