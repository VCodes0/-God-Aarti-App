import 'dart:async';
import 'package:aarti_app/controller/fetival_list_controller.dart';
import 'package:aarti_app/models/festival_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicScreen3 extends StatefulWidget {
  final Data data;
  final String imageUrl;
  final String audioUrl;

  const MusicScreen3({
    super.key,
    required this.data,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  State<MusicScreen3> createState() => _MusicScreen3State();
}

class _MusicScreen3State extends State<MusicScreen3> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late StreamSubscription<PlayerState> _playerStateSubscription;
  late StreamSubscription<Duration> _durationSubscription;
  late StreamSubscription<Duration> _positionSubscription;

  late FestivalListController _data;

  @override
  void initState() {
    super.initState();

    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((
      state,
    ) {
      if (!mounted) return;
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _durationSubscription = _audioPlayer.onDurationChanged.listen((
      newDuration,
    ) {
      if (!mounted) return;
      setState(() => duration = newDuration);
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((
      newPosition,
    ) {
      if (!mounted) return;
      setState(() => position = newPosition);
    });

    _data = FestivalListController();
    _data.getFestivalAartiData();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    _audioPlayer.dispose();
    _data.dispose();
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
    return ChangeNotifierProvider<FestivalListController>.value(
      value: _data,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            widget.imageUrl.isNotEmpty
                ? Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            Container(color: Colors.black.withValues(alpha: 0.5)),
            SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Slider(
                    value: position.inSeconds.toDouble(),
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
                          _audioPlayer.seek(
                            Duration(seconds: position.inSeconds - 10),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle,
                          size: 64,
                          color: Colors.orange,
                        ),
                        onPressed: () async {
                          if (widget.audioUrl.isNotEmpty) {
                            if (isPlaying) {
                              await _audioPlayer.pause();
                            } else {
                              await _audioPlayer.play(
                                UrlSource(widget.audioUrl),
                              );
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Audio not available for this Aarti.',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.forward_10, color: Colors.white),
                        onPressed: () {
                          _audioPlayer.seek(
                            Duration(seconds: position.inSeconds + 10),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
