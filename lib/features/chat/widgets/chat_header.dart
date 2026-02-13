import 'package:flutter/material.dart';
import '../../discover/models/user_card_model.dart';

class ChatHeader extends StatelessWidget {
  final UserCardModel user;

  const ChatHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER CONTENT
        Container(
          padding: const EdgeInsets.fromLTRB(8, 12, 16, 14),
          color: Colors.black,
          child: Row(
            children: [
              /// 🔙 BACK BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 4),

              /// ✅ AVATAR
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.network(
                      user.photoUrl,
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// ONLINE BADGE
                  if (user.isOnline)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        width: 13,
                        height: 13,
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

              const SizedBox(width: 12),

              /// NAME + STATUS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.name}, ${user.age}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (!user.isOnline)
                          Text(
                            _formatLastSeen(user.lastSeen),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        if (!user.isOnline) const SizedBox(width: 10),
                        Text(
                          "${user.dialogsCount} dialogs",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${user.coins} coins",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// 👇 PREMIUM SPLIT LINE
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

  String _formatLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return "recently";

    final diff = DateTime.now().difference(lastSeen);

    if (diff.inMinutes < 1) return "just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} h ago";

    return "${diff.inDays} d ago";
  }
}
