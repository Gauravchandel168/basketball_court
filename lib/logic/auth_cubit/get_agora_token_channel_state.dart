part of 'get_agora_token_channel_cubit.dart';

@immutable
sealed class GetAgoraTokenChannelState {}

final class GetAgoraTokenChannelInitial extends GetAgoraTokenChannelState {}
final class GetAgoraTokenChannelLoading extends GetAgoraTokenChannelState {}
final class GetAgoraTokenChannelSuccess extends GetAgoraTokenChannelState {
  final GetAgoraTokenAndChannelModel getAgoraTokenAndChannelModel;
  GetAgoraTokenChannelSuccess(this.getAgoraTokenAndChannelModel);
}
final class GetAgoraTokenChannelError extends GetAgoraTokenChannelState {
 final String message;
  GetAgoraTokenChannelError(this.message);
}
