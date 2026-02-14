import 'package:flutter/material.dart';
import '../models/user_card_model.dart';

class UserCard extends StatelessWidget {
  final UserCardModel user;
  final bool isPinned;
  final VoidCallback? onTap; // 👈 universal navigation hook

  const UserCard({
    super.key,
    required this.user,
    this.isPinned = false,
    this.onTap,
  });

  int _levelToInt(String level) {
    switch (level) {
      case "A1":
        return 1;
      case "A2":
        return 2;
      case "B1":
        return 3;
      case "B2":
        return 4;
      case "C1":
      case "C2":
        return 5;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedLanguages = [
      ...user.languages.where((l) => l.language == user.nativeLanguage),
      ...user.languages.where((l) => l.language != user.nativeLanguage),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap, // 👈 tashqaridan boshqariladi
        child: Stack(
          children: [
            /// TOP RIGHT STATS
            Positioned(
              right: 0,
              top: 0,
              child: Row(
                children: [
                  Text(
                    "💬 ${user.dialogsCount}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "🪙 ${user.coins}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// AVATAR
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    user.photoUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// NAME
                      Row(
                        children: [
                          Text(user.countryFlag),
                          const SizedBox(width: 6),
                          Text(
                            "${user.name}, ${user.age}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// LANGUAGES
                      SizedBox(
                        height: 48,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: sortedLanguages.map((lang) {
                              final level = _levelToInt(lang.level);
                              final isNative =
                                  lang.language == user.nativeLanguage;

                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    /// LANGUAGE BOX
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isNative
                                              ? Colors.blueAccent
                                              : Colors.white.withOpacity(0.08),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lang.language,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),

                                          /// LEVEL DOTS
                                          Row(
                                            children: List.generate(
                                              5,
                                              (i) => Container(
                                                margin: const EdgeInsets.only(
                                                    right: 3),
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: i < level
                                                      ? Colors.blueAccent
                                                      : Colors.white
                                                          .withOpacity(0.15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// NATIVE BADGE
                                    if (isNative)
                                      Positioned(
                                        right: -6,
                                        top: -6,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            "N",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
