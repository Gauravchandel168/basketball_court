import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../routers/app_routers.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  void _sendMessage(String text) {
    // Simulate message sending and receiving
    setState(() {
      _messages.add(Message(text: text, isSentByUser: true));
    });

    // Simulate receiving a message
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add(Message(text: 'Received: $text', isSentByUser: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Messages List
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageBubble(message: message);
                },
              ),
            ),
            // Typing Indicator (optional)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Simulate typing indicator
                  if (_messages.isNotEmpty &&
                      !_messages.last.isSentByUser)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Typing...'),
                    ),
                ],
              ),
            ),
            // Input and Send Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child:_searchField( context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send,
                    color: blackFF101010Color,
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
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
        textStyle: const TextStyle(fontWeight: normal, fontSize: 14),
      ),
      decoration: const InputDecoration(
        hintText: "Type a message",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintStyle: TextStyle(fontWeight: normal,
            color: blackFF101010Color,
            fontSize: 14),
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

class Message {
  final String text;
  final bool isSentByUser;

  Message({required this.text, required this.isSentByUser});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: message.isSentByUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: message.isSentByUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
