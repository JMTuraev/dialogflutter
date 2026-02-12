import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              const SizedBox(height: 20),

              /// Greeting
              const Text(
                "Welcome back,",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 4),
              const Text(
                "Jafar",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 28),

              /// Wallet Card
              _WalletCard()
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2),

              const SizedBox(height: 32),

              /// Categories
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const _CategoryRow(),

              const SizedBox(height: 32),

              /// Featured
              const Text(
                "Featured Speakers",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const _SpeakerHorizontalList(),

              const SizedBox(height: 60),

              /// EXTRA SPACE (scroll har doim ishlashi uchun)
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1C1F2A),
            Color(0xFF14161F),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Balance",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "240",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms),
              const SizedBox(width: 8),
              const Icon(Icons.monetization_on_rounded, color: AppTheme.gold),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text("Buy Coins"),
          )
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow();

  @override
  Widget build(BuildContext context) {
    final categories = ["English", "Russian", "Arabic", "Business"];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(categories[index]),
        ),
      ),
    );
  }
}

class _SpeakerHorizontalList extends StatelessWidget {
  const _SpeakerHorizontalList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (_, index) => _SpeakerCard(index: index),
      ),
    );
  }
}

class _SpeakerCard extends StatelessWidget {
  final int index;

  const _SpeakerCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 12),
          Text(
            "Speaker $index",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "4.9 ⭐",
            style: TextStyle(color: Colors.white70),
          ),
          const Spacer(),
          Row(
            children: const [
              Icon(Icons.monetization_on, size: 16, color: AppTheme.gold),
              SizedBox(width: 4),
              Text("15/min"),
            ],
          )
        ],
      ),
    );
  }
}
