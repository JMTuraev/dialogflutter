import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

import '../../discover/models/user_card_model.dart';
import 'audio_message_bubble.dart';
import 'dialog_agreement_card.dart';
import 'chat_input.dart';

class AudioMessage {
  final String path;
  final Duration duration;
  final DateTime sentAt;
  final bool isMe;

  AudioMessage({
    required this.path,
    required this.duration,
    required this.sentAt,
    required this.isMe,
  });
}

class ChatBody extends StatefulWidget {
  final bool isUnlocked;
  final UserCardModel user;
  final VoidCallback onUnlock;

  const ChatBody({
    super.key,
    required this.isUnlocked,
    required this.user,
    required this.onUnlock,
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final List<AudioMessage> messages = [];

  final ScrollController _scrollController = ScrollController();
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  bool isRecording = false;
  int remainingMessages = 20;

  Duration _recordDuration = Duration.zero;
  Timer? _recordTimer;

  String? _currentlyPlayingPath;
  StreamSubscription<PlayerState>? _playerSub;

  // ================= RECORD =================

  Future<void> _startRecording() async {
    if (!widget.isUnlocked) return;
    if (isRecording) return;

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) return;

    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    _recordDuration = Duration.zero;

    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _recordDuration += const Duration(seconds: 1);
      });
    });

    setState(() {
      isRecording = true;
    });
  }

  Future<void> _stopRecording({bool cancel = false}) async {
    if (!isRecording) return;

    _recordTimer?.cancel();
    _recordTimer = null;

    final path = await _recorder.stop();

    if (!mounted) return;

    setState(() {
      isRecording = false;
    });

    if (cancel || path == null) {
      if (path != null) File(path).deleteSync();
      return;
    }

    final temp = AudioPlayer();
    await temp.setFilePath(path);
    final duration = temp.duration ?? _recordDuration;
    await temp.dispose();

    setState(() {
      messages.add(
        AudioMessage(
          path: path,
          duration: duration,
          sentAt: DateTime.now(),
          isMe: true,
        ),
      );
      remainingMessages--;
    });

    _scrollToBottom();
  }

  // ================= PLAY =================

  Future<void> _playAudio(String path) async {
    if (_currentlyPlayingPath == path) {
      await _player.stop();
      setState(() {
        _currentlyPlayingPath = null;
      });
      return;
    }

    await _player.stop();
    await _player.setFilePath(path);
    await _player.play();

    setState(() {
      _currentlyPlayingPath = path;
    });
  }

  // ================= INIT =================

  @override
  void initState() {
    super.initState();

    _playerSub = _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _currentlyPlayingPath = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _recordTimer?.cancel();
    _recorder.dispose();
    _playerSub?.cancel();
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// MESSAGES AREA
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: messages.length + (widget.isUnlocked ? 0 : 1),
            itemBuilder: (context, index) {
              /// AGREEMENT CARD FIRST MESSAGE
              if (!widget.isUnlocked && index == 0) {
                return DialogAgreementCard(
                  user: widget.user,
                  onStart: (language, coins) {
                    widget.onUnlock();
                  },
                );
              }

              final realIndex = widget.isUnlocked ? index : index - 1;

              final message = messages[realIndex];

              return AudioMessageBubble(
                path: message.path,
                duration: message.duration,
                sentAt: message.sentAt,
                isMe: message.isMe,
                isPlaying: _currentlyPlayingPath == message.path,
                onPlay: () => _playAudio(message.path),
              );
            },
          ),
        ),

        /// RECORDING INDICATOR
        if (isRecording)
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.red.withOpacity(0.08),
            child: Text(
              "Recording... ${_formatDuration(_recordDuration)}",
              style: const TextStyle(color: Colors.red),
            ),
          ),

        /// INPUT (LOCKED / UNLOCKED)
        ChatInput(
          enabled: widget.isUnlocked,
          remainingMessages: remainingMessages,
          onMicLongPressStart: _startRecording,
          onMicLongPressEnd: () => _stopRecording(),
        ),
      ],
    );
  }

  // ================= HELPERS =================

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}
