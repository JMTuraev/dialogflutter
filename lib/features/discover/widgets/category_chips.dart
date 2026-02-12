import 'package:flutter/material.dart';

class CategoryChips extends StatefulWidget {
  final Function(String) onSelected;

  const CategoryChips({super.key, required this.onSelected});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String selected = "All";

  final List<String> languages = [
    "All",
    "English",
    "Spanish",
    "German",
    "Korean",
    "Japanese",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isActive = selected == lang;

          return GestureDetector(
            onTap: () {
              setState(() {
                selected = lang;
              });
              widget.onSelected(lang);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                lang,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white54,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
