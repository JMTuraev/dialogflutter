import 'package:flutter/material.dart';
import '../models/user_card_model.dart';
import '../../profile/profile_screen.dart';

class DiscoverHeader extends StatelessWidget {
  final UserCardModel currentUser;

  const DiscoverHeader({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 42;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// HEADER ROW
        SizedBox(
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// BRAND CENTER
              const Center(
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

              /// PROFILE CIRCLE (RIGHT)
              Positioned(
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: currentUser),
                      ),
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: Image.network(
                          currentUser.photoUrl,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// ONLINE BADGE
                      if (currentUser.isOnline)
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.greenAccent,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// SPLIT LINE
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
