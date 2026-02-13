import 'package:flutter/material.dart';
import '../models/user_card_model.dart';

class DiscoverHeader extends StatelessWidget {
  final UserCardModel currentUser;

  const DiscoverHeader({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER CONTENT
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 10), // 👈 kamaytirildi
          child: Row(
            children: [
              /// LEFT SPACE (brand center balance)
              const SizedBox(width: 42),

              /// BRAND CENTER
              const Expanded(
                child: Center(
                  child: Text(
                    "DIALOG",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              /// PROFILE AVATAR RIGHT
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.network(
                      currentUser.photoUrl,
                      width: 40, // ozgina kichraytirildi
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// ONLINE BADGE
                  if (currentUser.isOnline)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFF4CFF6A),
                              Color(0xFF00C853),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00C853).withOpacity(0.6),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        /// PREMIUM SPLIT LINE
        Container(
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0x33FFFFFF),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
