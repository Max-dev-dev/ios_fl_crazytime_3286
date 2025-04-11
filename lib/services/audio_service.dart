import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AudioPlayer _player = AudioPlayer();
  bool _isMusicOn = true;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isMusicOn = prefs.getBool('isMusicOn') ?? true;
    if (_isMusicOn) {
      await _player.setAsset('assets/main_music.wav');
      _player.setLoopMode(LoopMode.one);
      _player.play();
    }
  }

  void toggleMusic(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isMusicOn = value;
    await prefs.setBool('isMusicOn', _isMusicOn);
    if (_isMusicOn) {
      await _player.play();
    } else {
      await _player.pause();
    }
  }

  bool get isMusicOn => _isMusicOn;
}
