import 'package:basketball/logic/auth_cubit/user_hybrated_storage__cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/data_providers/http/custom_http_exception.dart';
import '../../data/model/auth_model/get_agora_token_and_channel_model.dart';
import '../../data/model/auth_token_model.dart';
import '../../data/respositories/http_repository/auth_repository.dart';
import '../internet/internet_cubit.dart';
import 'auth_token_store_cubit.dart';

part 'get_agora_token_channel_state.dart';

class GetAgoraTokenChannelCubit extends Cubit<GetAgoraTokenChannelState> {
  final AuthRepository authRepository;
  final InternetCubit internetCubit;
  final AuthTokenStoreCubit authTokenStoreCubit;
  final UserHybratedStorageCubit userHybratedStorageCubit;
  GetAgoraTokenChannelCubit(this.authRepository, this.internetCubit, this.authTokenStoreCubit, this.userHybratedStorageCubit) : super(GetAgoraTokenChannelInitial());

  getAgoraTokenChannel() async {
    if (!internetCubit.state) {
      emit(GetAgoraTokenChannelError("Internet is not available!"));
    } else {
      try {
        emit(GetAgoraTokenChannelLoading());
        AuthTokenModel authTokenModel =
        authTokenModelFromJson(authTokenStoreCubit.state ?? "");
        final GetAgoraTokenAndChannelModel getAgoraTokenAndChannelModel =
        await authRepository.getAgoraTokenChannel( userId: userHybratedStorageCubit.state?.id??"",
        token: authTokenModel.token ?? "");
        // if (getProfileModel.user?.username?.isNotEmpty == true) {
        //   emit(GetAgoraTokenChannelSuccess(getProfileModel));
        // } else {
        //   emit(GetAgoraTokenChannelError("No user available"));
        // }

           emit(GetAgoraTokenChannelSuccess(getAgoraTokenAndChannelModel));

      } catch (e) {
        if (e is CustomHttpException) {
          emit(GetAgoraTokenChannelError(e.error));
        } else {
          emit(GetAgoraTokenChannelError("Something went wrong"));
        }
      }
    }
  }
}
