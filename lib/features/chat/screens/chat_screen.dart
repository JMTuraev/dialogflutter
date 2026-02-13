import 'package:flutter/material.dart';
import '../../discover/models/user_card_model.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_body.dart';

class ChatScreen extends StatefulWidget {
  final UserCardModel user;

  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            ChatHeader(user: widget.user),

            /// BODY (ChatBody ichida ham messages ham input bor)
            Expanded(
              child: ChatBody(
                isUnlocked: isUnlocked,
                user: widget.user,
                onUnlock: () {
                  setState(() {
                    isUnlocked = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
