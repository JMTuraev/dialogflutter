import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AudioMessageBubble extends StatelessWidget {
  final String path;
  final Duration duration;
  final DateTime sentAt;
  final bool isMe;
  final bool isPlaying;
  final VoidCallback onPlay;

  const AudioMessageBubble({
    super.key,
    required this.path,
    required this.duration,
    required this.sentAt,
    required this.isMe,
    required this.isPlaying,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.amber : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onPlay,
              child: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 32,
                color: isMe ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDuration(duration),
                  style: TextStyle(
                    color: isMe ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('HH:mm').format(sentAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: isMe ? Colors.black54 : Colors.white54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}
