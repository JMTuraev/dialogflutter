import 'dart:ui';
import 'package:flutter/material.dart';
import 'data/discover_mock_data.dart';
import 'widgets/user_card.dart';
import 'widgets/discover_header.dart';
import '../chat/screens/chat_screen.dart';
import '../chats/screens/chats_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = DiscoverMockData.currentUser;
    final allUsers = DiscoverMockData.users;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
          children: [
            DiscoverHeader(currentUser: currentUser),
            const SizedBox(height: 30),
            ...allUsers.map(
              (user) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: UserCard(
                  user: user,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(user: user),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      /// 🌊 CHAT BUTTON → ChatsScreen
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatsScreen(),
                ),
              );
            },
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: const Color(0xFFFFC107).withOpacity(0.15),
                border: Border.all(
                  color: const Color(0xFFFFC107).withOpacity(0.35),
                  width: 1.2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.chat_bubble_rounded,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
