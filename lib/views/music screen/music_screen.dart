import 'dart:async';

import 'package:aarti_app/main.dart';
import 'package:aarti_app/models/recently_played_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  final RecentlyPlayedModel item;
  final String imageUrl;
  final String audioUrl;

  const MusicScreen({
    super.key,
    required this.item,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late final StreamSubscription<PlayerState> _playerStateSub;
  late final StreamSubscription<Duration> _durationSub;
  late final StreamSubscription<Duration> _positionSub;

  @override
  void initState() {
    super.initState();

    _playerStateSub = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    _durationSub = _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() => duration = newDuration);
      }
    });

    _positionSub = _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() => position = newPosition);
      }
    });
  }

  @override
  void dispose() {
    _playerStateSub.cancel();
    _durationSub.cancel();
    _positionSub.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(widget.imageUrl, fit: BoxFit.cover),
          Container(
            color: Colors.black.withAlpha(100),
          ), // semi-transparent overlay
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Slider(
                  value: position.inSeconds.toDouble().clamp(
                    0,
                    duration.inSeconds.toDouble(),
                  ),
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final newPosition = Duration(seconds: value.toInt());
                    await _audioPlayer.seek(newPosition);
                  },
                  activeColor: Colors.orange,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(position),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatTime(duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: () {
                        final newSeconds = (position.inSeconds - 10).clamp(
                          0,
                          duration.inSeconds,
                        );
                        _audioPlayer.seek(Duration(seconds: newSeconds));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 64,
                        color: Colors.orange,
                      ),
                      onPressed: () async {
                        if (isPlaying) {
                          await _audioPlayer.pause();
                        } else {
                          await _audioPlayer.play(UrlSource(widget.audioUrl));
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10, color: Colors.white),
                      onPressed: () {
                        final newSeconds = (position.inSeconds + 10).clamp(
                          0,
                          duration.inSeconds,
                        );
                        _audioPlayer.seek(Duration(seconds: newSeconds));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            top: mq.height * 0.02,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                widget.item.title ?? '',
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
