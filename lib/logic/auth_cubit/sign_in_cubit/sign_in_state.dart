part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}


class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final SignInResponse signInResponseModel;
  SignInSuccess(this.signInResponseModel);
}

class SignInError extends SignInState {
  final String message;
  SignInError(this.message);
}
