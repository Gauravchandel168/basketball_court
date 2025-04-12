// import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
import 'package:agora_rtm/agora_rtm.dart';
part 'chat_state.dart';
class ChatCubit extends Cubit<ChatState> {
  late AgoraRtmClient _client;
  AgoraRtmChannel? _channel;
  final String appId;
  final String channelId;



  ChatCubit({required this.appId, required this.channelId}) : super(ChatInitial()){
    _initRtm();
  }
  Future<void> _initRtm() async {
    try {
      _client = await AgoraRtmClient.createInstance(appId);
      _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
        emit(ChatMessageReceived(
          text: message.text,
          isSentByUser: false,
        ));
      };

      _client.onConnectionStateChanged = (int state, int reason) {
        if (state == 5) {
          _client.logout();
        }
      };

      await _client.login(null, 'user_${DateTime.now().millisecondsSinceEpoch}');

      _channel = await _client.createChannel(channelId,);
      _channel?.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember member) {
        emit(ChatMessageReceived(
          text: message.text,
          isSentByUser: false,
        ));
      };

      await _channel?.join();

      emit(ChatConnected());
    } catch (e) {
      emit(ChatError("RTM Init Failed: $e"));
    }
  }

  Future<void> sendMessage(String text) async {
    if (_channel != null) {
      try {
        await _channel!.sendMessage(AgoraRtmMessage.fromText(text));
        emit(ChatMessageReceived(text: text, isSentByUser: true));
      } catch (e) {
        emit(ChatError("Send Failed: $e"));
      }
    }
  }

  @override
  Future<void> close() async {
    await _channel?.leave();
    await _channel?.release();
    await _client.logout();
    await _client.destroy();
    return super.close();
  }
}
