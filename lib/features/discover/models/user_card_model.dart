class UserCardModel {
  final String name;
  final int age;
  final String countryFlag;
  final String photoUrl;
  final String nativeLanguage;
  final List<LanguageModel> languages;
  final int dialogsCount;
  final int coins;

  UserCardModel({
    required this.name,
    required this.age,
    required this.countryFlag,
    required this.photoUrl,
    required this.nativeLanguage,
    required this.languages,
    required this.dialogsCount,
    required this.coins,
  });
}

class LanguageModel {
  final String language;
  final String level;

  LanguageModel({
    required this.language,
    required this.level,
  });
}
