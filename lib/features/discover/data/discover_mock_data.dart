import '../models/user_card_model.dart';

class DiscoverMockData {
  static UserCardModel currentUser = UserCardModel(
    name: "Your Name",
    age: 27,
    countryFlag: "🇺🇿",
    photoUrl: "https://randomuser.me/api/portraits/men/10.jpg",
    nativeLanguage: "Uzbek",
    languages: [
      LanguageModel(language: "Uzbek", level: "C2"),
      LanguageModel(language: "English", level: "C1"),
      LanguageModel(language: "Russian", level: "B2"),
    ],
    dialogsCount: 210,
    coins: 1250,
    isOnline: true,
  );

  static List<UserCardModel> users = [
    UserCardModel(
      name: "Alex Morgan",
      age: 26,
      countryFlag: "🇺🇸",
      photoUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      nativeLanguage: "English",
      languages: [
        LanguageModel(language: "English", level: "C2"),
        LanguageModel(language: "Spanish", level: "B2"),
      ],
      dialogsCount: 124,
      coins: 580,
      isOnline: true,
      hasChat: true, // 🔥 yozishilgan
    ),
    UserCardModel(
      name: "Sara Kim",
      age: 24,
      countryFlag: "🇰🇷",
      photoUrl: "https://randomuser.me/api/portraits/women/44.jpg",
      nativeLanguage: "Korean",
      languages: [
        LanguageModel(language: "Korean", level: "C2"),
        LanguageModel(language: "English", level: "C1"),
      ],
      dialogsCount: 89,
      coins: 430,
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(minutes: 20)),
      hasChat: true,
    ),
    ...List.generate(18, (index) {
      final id = index + 50;
      return UserCardModel(
        name: "User $id",
        age: 20 + (index % 8),
        countryFlag: index % 2 == 0 ? "🇩🇪" : "🇫🇷",
        photoUrl:
            "https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/$id.jpg",
        nativeLanguage: index % 2 == 0 ? "German" : "French",
        languages: [
          LanguageModel(language: "English", level: "B2"),
          LanguageModel(language: "Spanish", level: "A2"),
        ],
        dialogsCount: 50 + index * 3,
        coins: 200 + index * 15,
        isOnline: index % 3 == 0,
        hasChat: index % 4 == 0, // 🔥 filter uchun
      );
    }),
  ];
}
