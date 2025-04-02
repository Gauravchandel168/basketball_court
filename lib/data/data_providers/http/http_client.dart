import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/signup_model/signup_request_model.dart';
import 'api_urls.dart';

class MyHttpClient {
  final Map<String, String> headers = {'Content-type': 'application/json'};

  Future<http.Response> get(String uri, String token) async {
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    return response;
  }

  Future<dynamic> post(String uri, String token,
      {required Map<String, dynamic> body}) async {
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> signUp(
      {required SignupRequestModel signUpRequestModel,
      required String img}) async {
    //  dynamic response = await post(SIGN_UP, body: body);
    var url = Uri.parse(SIGN_UP_URL);
    final response = http.MultipartRequest('POST', url);
    response.headers.addAll({"Content-type": "application/json"});
    response.files.add(await http.MultipartFile.fromPath("profile", img));

    response.fields.addAll({
      "email": signUpRequestModel.email ?? "",
      "username": signUpRequestModel.username ?? "",
      "password": signUpRequestModel.password ?? "",
      "age": (signUpRequestModel.age).toString() ?? "",
    });

    var request = await response.send();
    var responded = await http.Response.fromStream(request);
    return responded;
  }

  Future<http.Response> updateProfile(
      {required SignupRequestModel signUpRequestModel,
      required String token,
      required String img}) async {
    //  print(signupRequestModelToJson(signUpRequestModel));
    //  dynamic response = await post(SIGN_UP, body: body);
    var url = Uri.parse(GET_PROFILE_URL);
    final response = http.MultipartRequest('PUT', url);
    response.headers.addAll({
      "Content-type": "multipart/form-data",
      'Authorization': "Bearer $token"
    });
    if (img.isNotEmpty) {
      response.files.add(await http.MultipartFile.fromPath("profile", img));
    }
    // response.files.add(await http.MultipartFile.fromPath("profile", img));

    response.fields.addAll({
      "username": signUpRequestModel.username ?? "",
      "password": signUpRequestModel.password ?? "",
      "age": (signUpRequestModel.age).toString(),
    });

    var request = await response.send();
    var responded = await http.Response.fromStream(request);

    return responded;
  }

  Future<http.Response> signIn(
      {required Map<String, dynamic> body, required String token}) async {
    return await post(SIGN_IN_URL, token, body: body);
  }

  Future<http.Response> getUserProfile(String token) async {
    return await get(GET_PROFILE_URL, token);
  }

  Future<http.Response> getAllLearning(String token) async {
    return await get(GET_ALL_LEARNING_URL, token);
  }

  Future<http.Response> marklearningCompleted(
      {required String learningId, required String token}) async {
    return await post(
        MARK_LEARNING_COMPLETED_URL(learningId: learningId), token,
        body: {});
  }

  Future<http.Response> markQuizCompleted(
      {required String learningId,
      required String quizId,
      required selectedAnswerId,
      required String token}) async {
    return await post(
        MARK_QUIZ_COMPLETED_URL(learningId: learningId, quizId: quizId), token,
        body: {"selectedAnswerId": "$selectedAnswerId"});
  }

  Future<http.Response> getAllLearningSection(String token) async {
    return await get(GET_ALL_LEARNING_URL, token);
  }

  Future<http.Response> getShipment(String token) async {
    return await get(GET_SHIPMENT_URL, token);
  }

  Future<http.Response> getAllPrize(String token) async {
    return await get(GET_ALL_PRIZE_URL, token);
  }

  Future<http.Response> buyPrizes(
      {
        required Map<String, dynamic> body,
        required String prizeId,
        required String token}) async {
    return await post(
        BUY_PRIZES_URL(prizeId:prizeId ), token,
        body: body
    );
  }
}
