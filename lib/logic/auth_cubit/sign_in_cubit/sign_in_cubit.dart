
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/sigin_model/sign_in_response.dart';
import '../../../data/model/sigin_model/signin_exception.dart';
import '../../../data/respositories/http_repository/auth_repository.dart';

import '../../internet/internet_cubit.dart';
import '../auth_token_store_cubit.dart';
import '../user_hybrated_storage__cubit.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final InternetCubit internetCubit;
  final AuthRepository authRepository;
  final AuthTokenStoreCubit authTokenStoreCubit;
  final UserHybratedStorageCubit userHybratedStorageCubit;

  SignInCubit(this.internetCubit, this.authRepository, this.authTokenStoreCubit, this.userHybratedStorageCubit)
      : super(SignInInitial());
  signINMethod(String name, String password) async {
    final u = name.trim();
    final p = password.trim();

    if (u.isEmpty || p.isEmpty) {
      emit(SignInError("Please complete all fields of the form."));
    } else if (!internetCubit.state) {
      emit(SignInError("Internet is not available!"));
    } else {
      try {
        emit(SignInLoading());
        SignInResponse signInResponseModel = await authRepository.signInMethod(
            username: u, password: p, token: '');
        authTokenStoreCubit.setAuthToken(signInResponseModel.accessToken ?? "");
        final user = signInResponseModel.user;
        if(user != null) {
          userHybratedStorageCubit.setUser(user);
          emit(SignInSuccess());
        }else{
          emit(SignInError("Something went wrong!"));
        }
        emit(SignInSuccess());
        print("state");
        print(state);

      } on SigninException catch (e) {

        if (e.error?.toLowerCase() == "invalid credentials") {
          emit(SignInError(e.error!));
        } else {
          emit(SignInError("Something went wrong. Please try again."));
        }
      } catch (e) {

print("object");
print(e.toString());

        emit(SignInError("Something went wrong. Please try again."));
      }
    }
  }
}
