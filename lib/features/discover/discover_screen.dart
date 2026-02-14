import 'dart:ui';
import 'package:flutter/material.dart';
import 'data/discover_mock_data.dart';
import 'widgets/user_card.dart';
import 'widgets/discover_header.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool isChats = false;
  int unreadCount = 4;

  @override
  Widget build(BuildContext context) {
    final currentUser = DiscoverMockData.currentUser;
    final users = DiscoverMockData.users;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: SafeArea(
        child: IndexedStack(
          index: isChats ? 1 : 0,
          children: [
            /// 🔎 DISCOVER
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              children: [
                DiscoverHeader(currentUser: currentUser),
                const SizedBox(height: 30),
                ...users.map(
                  (user) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: UserCard(user: user),
                  ),
                ),
              ],
            ),

            /// 💬 CHATS
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141A22),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Chat conversation $index",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      /// 🌊 AMBER GLASS FLOAT BUTTON
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isChats = !isChats;
                    unreadCount = 0;
                  });
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
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Icon(
                          isChats ? Icons.explore_rounded : Icons.chat_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// 🔴 BADGE
          if (!isChats && unreadCount > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
