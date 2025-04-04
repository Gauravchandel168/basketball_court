import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/model/auth_token_model.dart';

class AuthTokenStoreCubit extends HydratedCubit<String?> {
  AuthTokenStoreCubit() : super(null);

  setAuthToken(String token) {
    AuthTokenModel authTokenModel = AuthTokenModel(
        timestamp: DateTime.now().toIso8601String(), token: token);
    emit(authTokenModelToJson(authTokenModel));
  }

  clearData() async {
    await clear();
    emit(null);
  }

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json["token"];
  }

  @override
  Map<String, dynamic>? toJson(String? state) {
    return authTokenModelFromJson(state ?? '').toJson();
  }
}
