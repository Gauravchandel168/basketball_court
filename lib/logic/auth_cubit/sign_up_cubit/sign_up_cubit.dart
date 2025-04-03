import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/data_providers/http/custom_http_exception.dart';
import '../../../data/model/user_model.dart';
import '../../internet/internet_cubit.dart';


part 'sign_up_state.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   final InternetCubit internetCubit;
//  // final AuthRepository authRepository;
//   SignUpCubit(this.internetCubit,) : super(SignUpInitial());
//   signUpMethod(
//     String name,
//     String email,
//     String password,
//     String confirmPassword,
//     num age,
//     String? img,
//   ) async {
//     final a = age;
//     final u = name.trim();
//     final p = password.trim();
//     final e = email.trim();
//
//     if (u.isEmpty || e.isEmpty || p.isEmpty || a == 0) {
//       emit(SignUpError("Please complete all fields of the form."));
//     } else if (img?.isNotEmpty == false) {
//       emit(SignUpError("Please select image."));
//     } else if (!EmailValidator.validate(e)) {
//       emit(SignUpError("Please enter valid email address"));
//     } else if (password != confirmPassword) {
//       emit(SignUpError("your password was don't match "));
//     } else if (!internetCubit.state) {
//       emit(SignUpError("Internet is not available!"));
//     } else {
//       try {
//         emit(SignUpLoading());
//         SignupResponseModel signupResponseModel =
//             await authRepository.signUpMethod(
//                 username: u, password: p, email: e, age: age, img: img ?? "");
//         emit(SignUpSuccess(signupResponseModel));
//       } catch (e) {
//         if (e is CustomHttpException) {
//           if (e.error.toLowerCase().contains(
//               "This email is already associated with an account"
//                   .toLowerCase())) {
//             emit(SignUpError(e.error));
//           } else {
//             emit(SignUpError(e.error));
//           }
//         } else {
//           emit(SignUpError("Something went wrong. Please try again."));
//         }
//       }
//     }
//   }
//
//
//   Future<void> saveUser(Map<String, dynamic> userData) async {
//     if (u.isEmpty || e.isEmpty || p.isEmpty || a == 0) {
//       emit(SignUpError("Please complete all fields of the form."));
//     }
//     // else if (img?.isNotEmpty == false) {
//     //   emit(SignUpError("Please select image."));
//     // }
//     else if (!EmailValidator.validate(e)) {
//       emit(SignUpError("Please enter valid email address"));
//     } else if (password != confirmPassword) {
//       emit(SignUpError("your password was don't match "));
//     } else if (!internetCubit.state) {
//       emit(SignUpError("Internet is not available!"));
//     } else{ try {
//       emit(SignUpLoading()); // Emit loading state
//
//       var box = await Hive.openBox<UserModel>('userBox');
//       UserModel user = UserModel.fromJson(userData);
//       await box.put('user1', user);
//
//       emit(SignUpSuccess(user)); // Emit success state
//     } catch (e) {
//       emit(SignUpError('Failed to save user data.')); // Emit error state
//     }}
//   }
// }



class SignUpCubit extends Cubit<SignUpState> {
  final InternetCubit internetCubit;

  // final AuthRepository authRepository;

  SignUpCubit(this.internetCubit) : super(SignUpInitial());

  Future<void> signUpMethod(String name,
      String email,
      String password,
      String confirmPassword,
      num age,
      // String? img,
      ) async {
    final u = name.trim();
    final e = email.trim();
    final p = password.trim();

    if (u.isEmpty || e.isEmpty || p.isEmpty || age == 0) {
      emit(SignUpError("Please complete all fields of the form."));
      return;
    }

    // if (img?.isNotEmpty == false) {
    //   emit(SignUpError("Please select an image."));
    //   return;
    // }

    if (!EmailValidator.validate(e)) {
      emit(SignUpError("Please enter a valid email address."));
      return;
    }

    if (password != confirmPassword) {
      emit(SignUpError("Your passwords do not match."));
      return;
    }

    if (!internetCubit.state) {
      emit(SignUpError("Internet is not available!"));
      return;
    }

    try {
      emit(SignUpLoading()); // Emit loading state

      // Store user in Hive
      var box = await Hive.openBox<UserModel>('userBox');
      UserModel user = UserModel(
        email: e,
        username: u,
        password: p,
        age: age.toInt(),
      );
      await box.put('user1', user);

      // Mock API Signup call (Uncomment this if using an API)
      // SignupResponseModel signupResponseModel = await authRepository.signUpMethod(
      //   username: u, password: p, email: e, age: age, img: img ?? ""
      // );

      emit(SignUpSuccess(user));// Emit success state

    } catch (e) {

      if (e is CustomHttpException) {
        if (e.error.toLowerCase().contains(
            "This email is already associated with an account"
                .toLowerCase())) {
          emit(SignUpError(e.error));
        } else {
          emit(SignUpError(e.error));
        }
      }
      else {
        emit(SignUpError("Something went wrong. Please try again."));
      }
    }
  }

  // Get user data from Hive
  Future<void> getUser(String email) async {
    emit(SignUpLoading());

    try {
      var box = await Hive.openBox<UserModel>('userBox');
      UserModel? user = box.get(email);

      if (user != null) {
        emit(SignUpSuccess(user));
      } else {
        emit(SignUpError("User not found!"));
      }
    } catch (e) {
      if (e is CustomHttpException) {
        emit(SignUpError("Error fetching user data!"));
      }
    }
  }
}


