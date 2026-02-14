import 'package:flutter/material.dart';
import '../discover/models/user_card_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserCardModel user;

  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// AVATAR
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.photoUrl),
          ),

          const SizedBox(height: 16),

          /// NAME
          Text(
            "${user.name}, ${user.age}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            user.countryFlag,
            style: const TextStyle(fontSize: 20),
          ),

          const SizedBox(height: 20),

          /// STATS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStat("Dialogs", user.dialogsCount.toString()),
              const SizedBox(width: 30),
              _buildStat("Coins", user.coins.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
