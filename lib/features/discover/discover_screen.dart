import 'package:flutter/material.dart';
import 'models/user_card_model.dart';
import 'widgets/user_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = UserCardModel(
      name: "Your Name",
      age: 27,
      countryFlag: "🇺🇿",
      photoUrl: "https://randomuser.me/api/portraits/men/10.jpg",
      nativeLanguage: "Uzbek",
      languages: [
        LanguageModel(language: "English", level: "C1"),
        LanguageModel(language: "Russian", level: "B2"),
        LanguageModel(language: "German", level: "A2"),
        LanguageModel(language: "Spanish", level: "B1"),
        LanguageModel(language: "French", level: "B1"),
      ],
      dialogsCount: 210,
      coins: 1250,
    );

    final users = [
      UserCardModel(
        name: "Alex Morgan",
        age: 26,
        countryFlag: "🇺🇸",
        photoUrl: "https://randomuser.me/api/portraits/men/32.jpg",
        nativeLanguage: "English",
        languages: [
          LanguageModel(language: "Spanish", level: "B2"),
          LanguageModel(language: "German", level: "A2"),
        ],
        dialogsCount: 124,
        coins: 580,
      ),
      UserCardModel(
        name: "Sara Kim",
        age: 24,
        countryFlag: "🇰🇷",
        photoUrl: "https://randomuser.me/api/portraits/women/44.jpg",
        nativeLanguage: "Korean",
        languages: [
          LanguageModel(language: "English", level: "C1"),
          LanguageModel(language: "Japanese", level: "B1"),
        ],
        dialogsCount: 89,
        coins: 430,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            const Text(
              "DIALOG",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            UserCard(
              user: currentUser,
              isPinned: true,
            ),
            const SizedBox(height: 32),
            ...users.map(
              (user) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: UserCard(user: user),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
