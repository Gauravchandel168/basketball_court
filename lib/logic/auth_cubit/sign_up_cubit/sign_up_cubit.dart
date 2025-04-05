import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meta/meta.dart';

import '../../../data/data_providers/http/custom_http_exception.dart';
import '../../../data/model/signup_model/signup_response_model.dart';
import '../../../data/respositories/http_repository/auth_repository.dart';
import '../../internet/internet_cubit.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final InternetCubit internetCubit;
  final AuthRepository authRepository;
  SignUpCubit(this.internetCubit, this.authRepository) : super(SignUpInitial());
  signUpMethod(
      String name,
      String email,
      String password,
     // String confirmPassword,
      num age,
      String? img,
      ) async {
    final a = age;
    final u = name.trim();
    final p = password.trim();
    final e = email.trim();

    if (u.isEmpty || e.isEmpty || p.isEmpty || a == 0) {
      emit(SignUpError("Please complete all fields of the form."));
    } else if (img?.isNotEmpty == false) {
      emit(SignUpError("Please select image."));
    } else if (!EmailValidator.validate(e)) {
      emit(SignUpError("Please enter valid email address"));
    }
    // else if (password != confirmPassword) {
    //   emit(SignUpError("your password was don't match "));
    // }
    else if (!internetCubit.state) {
      emit(SignUpError("Internet is not available!"));
    } else {
      try {
        emit(SignUpLoading());
        SignupResponseModel signupResponseModel =
        await authRepository.signUpMethod(
            username: u, password: p, email: e, age: age, img: img ?? "");
        emit(SignUpSuccess(signupResponseModel));
      } catch (e) {
        if (e is CustomHttpException) {
          if (e.error.toLowerCase().contains(
              "This email is already associated with an account"
                  .toLowerCase())) {
            emit(SignUpError(e.error));
          } else {
            emit(SignUpError(e.error));
          }
        } else {
          emit(SignUpError("Something went wrong. Please try again."));
        }
      }
    }
  }
}
