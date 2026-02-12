import 'package:flutter/material.dart';
import 'package:dialog/features/discover/models/user_card_model.dart';

class UserProfileScreen extends StatelessWidget {
  final UserCardModel user;

  const UserProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "${user.name}, ${user.age}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
