import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final bool enabled;
  final int remainingMessages;
  final VoidCallback onMicLongPressStart;
  final VoidCallback onMicLongPressEnd;

  const ChatInput({
    super.key,
    required this.enabled,
    required this.remainingMessages,
    required this.onMicLongPressStart,
    required this.onMicLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TOP SPLIT LINE (header style)
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

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          color: Colors.black,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// FILE BUTTON
                  _sideButton(
                    icon: Icons.attach_file,
                    enabled: enabled,
                  ),

                  /// MAIN MIC BUTTON
                  GestureDetector(
                    onLongPressStart: (_) =>
                        enabled ? onMicLongPressStart() : null,
                    onLongPressEnd: (_) => enabled ? onMicLongPressEnd() : null,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: enabled
                            ? const RadialGradient(
                                colors: [
                                  Color(0xFFFFD54F),
                                  Color(0xFFFFB300),
                                ],
                              )
                            : const RadialGradient(
                                colors: [
                                  Colors.grey,
                                  Colors.black45,
                                ],
                              ),
                        boxShadow: enabled
                            ? [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.6),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.mic,
                        size: 28,
                        color: enabled ? Colors.black : Colors.white38,
                      ),
                    ),
                  ),

                  /// IMAGE BUTTON
                  _sideButton(
                    icon: Icons.image_outlined,
                    enabled: enabled,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// LIMIT COUNTER
              Text(
                "$remainingMessages / 20 messages left today",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      remainingMessages > 5 ? Colors.white60 : Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sideButton({
    required IconData icon,
    required bool enabled,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.04),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Icon(
        icon,
        size: 20,
        color: enabled ? Colors.white70 : Colors.white24,
      ),
    );
  }
}
