import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/sigin_model/sign_in_response.dart';



class UserHybratedStorageCubit extends Cubit<User?> {
  UserHybratedStorageCubit() : super(null);

  setUser(User user) => emit(user);

  @override
  User? fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(User? state) {
    return state?.toJson();
  }
}
