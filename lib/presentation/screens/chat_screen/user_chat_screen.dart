import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../logic/chat_cubit.dart';
import '../../routers/app_routers.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(text);
      _controller.clear();
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatMessageReceived) {
          setState(() {
            _messages.add({
              'text': state.text,
              'isMe': state.isSentByUser,
            });
          });
        } else if (state is ChatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],

        appBar: AppBar(
          // centerTitle: true,
          elevation: 3,
          primary: true,
          actionsPadding: EdgeInsets.zero,
          leadingWidth: 0,
          backgroundColor: whiteFFFFFFColor,
          leading: InkWell(
            onTap: () {
              AppRouter.navigatorKey.currentState?.pop();
            },
            child:const Icon(Icons.arrow_back_rounded,
              color: blackFF101010Color,
            ),
          ),
          actions:  [
            const Icon(CupertinoIcons.video_camera_solid,
              color: blackFF101010Color,
            ),
            SizedBox(width: 20,),
            InkWell(
              onTap: (){
                // AppRouter.navigatorKey.currentState?.pushNamed(
                //   AppRouter.notificationScreen,
                // );
              },
              child: const Icon(Icons.call,
                color: blackFF101010Color,
              ),
            ),
            SizedBox(width: 20,),

            const Icon(Icons.more_vert_outlined,
              color: blackFF101010Color,
            ),
            SizedBox(width: 10,),

          ],
          title: Row(
            children: [
              SizedBox(width: 20,),

              const CircleAvatar(backgroundColor: Colors.grey, radius: 20),

              Text(
                "   Agora Chat",
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: bold,
                    color: blackFF101010Color,

                  ),
                ),
              ),
            ],
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isMe = message['isMe'] as bool;
                    final text = message['text'] as String;
                  return   MessageBubble(
                      isMe:isMe ,
                      text: text);
                    // return Align(
                    //   alignment:
                    //   isMe ? Alignment.centerRight : Alignment.centerLeft,
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(vertical: 4),
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 14),
                    //     decoration: BoxDecoration(
                    //       color: isMe ? Colors.blue : Colors.grey[300],
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Text(
                    //       text,
                    //       style: TextStyle(
                    //         color: isMe ? Colors.white : Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child:_searchField( context)
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send,
                        color: blackFF101010Color,
                        size: 40,
                      ),
                      onPressed: _sendMessage,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _searchField(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: blackFF101010Color,
      keyboardType: TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontWeight: normal, fontSize: 19),
      ),
      decoration: const InputDecoration(
        hintText: "Type a message",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintStyle: TextStyle(fontWeight: normal,
            color: blackFF101010Color,
            fontSize: 19),

        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(width: 30, color: whiteFFFFFFColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(width: 30, color: whiteFFFFFFColor),
        ),
      ),
    );
  }

}
class MessageBubble extends StatelessWidget {
  bool isMe;
  String text;

   MessageBubble({
     super.key,
     required this.isMe,
     required this.text,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
        Align(
          alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
        )
    );
  }
}
