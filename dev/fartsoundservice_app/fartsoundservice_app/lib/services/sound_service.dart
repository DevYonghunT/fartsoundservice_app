import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum SoundSelectionMode {
  auto,
  manual;
}

class SoundService with ChangeNotifier {
  SoundSelectionMode _selectionMode = SoundSelectionMode.auto;
  int _manualIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<String> _soundFiles = List.generate(10, (i) => 'fart${(i + 1).toString().padLeft(2, '0')}.mp3');

  SoundSelectionMode get selectionMode => _selectionMode;
  int get manualIndex => _manualIndex;

  set selectionMode(SoundSelectionMode mode) {
    if (_selectionMode != mode) {
      _selectionMode = mode;
      notifyListeners();
    }
  }

  set manualIndex(int index) {
    if (_manualIndex != index) {
      _manualIndex = index;
      _selectionMode = SoundSelectionMode.manual;
      notifyListeners();
    }
  }

  Future<void> playRandomFart() async {
    String soundName;
    
    switch (_selectionMode) {
      case SoundSelectionMode.auto:
        soundName = _soundFiles[Random().nextInt(_soundFiles.length)];
        break;
      case SoundSelectionMode.manual:
        soundName = _soundFiles[_manualIndex];
        break;
    }

    try {
      await _audioPlayer.play(AssetSource('sounds/$soundName'));
      _audioPlayer.setVolume(0.7 + Random().nextDouble() * 0.3);
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}