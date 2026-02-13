import 'package:flutter/material.dart';
import '../../discover/models/user_card_model.dart';

class DialogAgreementCard extends StatefulWidget {
  final UserCardModel user;
  final Function(String language, int coins) onStart;

  const DialogAgreementCard({
    super.key,
    required this.user,
    required this.onStart,
  });

  @override
  State<DialogAgreementCard> createState() => _DialogAgreementCardState();
}

class _DialogAgreementCardState extends State<DialogAgreementCard> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    if (widget.user.languages.isNotEmpty) {
      selectedLanguage = widget.user.languages.first.language;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.languages.isEmpty) {
      return const SizedBox();
    }

    final selectedLang =
        widget.user.languages.firstWhere((l) => l.language == selectedLanguage);

    final coins = _calculateCoins(selectedLang.level);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B2733).withOpacity(0.9),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// TITLE
            const Text(
              "Start this dialog",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            /// LANGUAGE SELECT
            ...widget.user.languages.map(
              (lang) {
                final langCoins = _calculateCoins(lang.level);
                final isSelected = selectedLanguage == lang.language;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang.language;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.amber.withOpacity(0.15)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? Colors.amber
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              lang.language,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "$langCoins coins",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.amber,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            /// CLEAR COST EXPLANATION
            Text(
              "Each message in this dialog costs $coins coins.",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 18),

            /// CONFIRM BUTTON
            GestureDetector(
              onTap: () {
                widget.onStart(
                  selectedLang.language,
                  coins,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Confirm & Start",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateCoins(String level) {
    switch (level) {
      case "A1":
      case "A2":
        return 1;
      case "B1":
        return 2;
      case "B2":
        return 3;
      case "C1":
      case "C2":
        return 4;
      default:
        return 2;
    }
  }
}
