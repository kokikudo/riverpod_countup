import 'package:audioplayers/audioplayers.dart';

class SoundLogic {
  static const SOUND_DATA_UP = 'sounds/up.mp3';
  static const SOUND_DATA_DOWN = 'sounds/down.mp3';
  static const SOUND_DATA_RESET = 'sounds/reset.mp3';

  // キャッシュの設定
  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(), // オーディオプレーヤーを設定する
  );

  // 音声の読み込み
  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  // 再生する
  void playUpSound() {
    _cache.play(SOUND_DATA_UP);
  }

  void playDownSound() {
    _cache.play(SOUND_DATA_DOWN);
  }

  void playResetSound() {
    _cache.play(SOUND_DATA_RESET);
  }
}
