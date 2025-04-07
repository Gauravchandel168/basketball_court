
import '../../data_providers/http/custom_http_exception.dart';
import '../../data_providers/http/http_client.dart';
import '../../model/auth_model/get_agora_token_and_channel_model.dart';
import '../../model/sigin_model/sign_in_request_model.dart';
import '../../model/sigin_model/sign_in_response.dart';
import '../../model/sigin_model/signin_exception.dart';
import '../../model/signup_model/signup_request_model.dart';
import '../../model/signup_model/signup_response_model.dart';

class AuthRepository {
  final myHttpClient = MyHttpClient();
  Future<SignupResponseModel> signUpMethod(
      {required String username,
      required num age,
      required String password,
      required String email,
      required String img}) async {
    final signUpRequestModel = SignupRequestModel(
        age: age, email: email, username: username, password: password);
    final response = await myHttpClient.signUp(
        signUpRequestModel: signUpRequestModel, img: img);
    if (response.statusCode == 201) {
      return signupResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CustomHttpException(
          error: signupResponseModelFromJson(response.body).message ??
              "Unauthorized Request.");
    } else {
      throw CustomHttpException(
          error: "Something went wrong. Please try again.");
    }
  }

  Future<SignInResponse> signInMethod(
      {required String username,
      required String password,
      required String token}) async {
    final signInRequestModel =
        SignInRequestModel(username: username, password: password);
    final response = await myHttpClient.signIn(
        body: signInRequestModel.toJson(), token: token);
    if (response.statusCode == 201) {
      return signInResponseFromJson(response.body);
    } else {
      throw signinExceptionFromJson(response.body);
    }
  }

  Future<GetAgoraTokenAndChannelModel> getAgoraTokenChannel({required String userId, required String token}) async {
    final response = await myHttpClient.getAgoraTokenChannel(userId: userId,token: token);

    var res = getAgoraTokenAndChannelModelFromJson(response.body);
    if (response.statusCode == 201) {
      return res;
    } else {
      throw CustomHttpException(error: res.message ?? "Something went wrong!");
    }
  }
}
