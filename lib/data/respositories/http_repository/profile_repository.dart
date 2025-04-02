
import '../../data_providers/http/custom_http_exception.dart';
import '../../data_providers/http/http_client.dart';
import '../../model/auth_model/get_profile_model.dart';
import '../../model/sigin_model/sign_in_response.dart';
import '../../model/signup_model/signup_request_model.dart';

class ProfileRepository {
  final myHttpClient = MyHttpClient();
  Future<GetProfileModel> getUserProfile(String token) async {
    final response = await myHttpClient.getUserProfile(token);
    // print(response.statusCode);

    var res = getProfileModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(error: res.message ?? "Something went wrong!");
    }
  }

  Future<SignInResponse> updateUser(
      String token, SignupRequestModel signUpRequestModel, String img) async {
    final response = await myHttpClient.updateProfile(
        token: token, signUpRequestModel: signUpRequestModel, img: img);
    var res = signInResponseFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(error: "Something went wrong!");
    }
  }
}
