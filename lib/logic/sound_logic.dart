import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_countup/data/count_data.dart';

class SoundLogic {
  // ignore: constant_identifier_names
  static const SOUND_DATA_UP = 'sounds/up.mp3';
  // ignore: constant_identifier_names
  static const SOUND_DATA_DOWN = 'sounds/down.mp3';
  // ignore: constant_identifier_names
  static const SOUND_DATA_RESET = 'sounds/reset.mp3';

  // キャッシュの設定
  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(), // オーディオプレーヤーを設定する
  );

  // 音声の読み込み
  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  // 再生する関数
  // タップ前後のカウントを比較して再生する音声を変える
  void valueChanges(CountData oldData, CountData newData) {
    if (newData.countUp == 0 && newData.countDown == 0) {
      playResetSound();
    } else if (newData.count > oldData.count) {
      playUpSound();
    } else if (newData.count < oldData.count) {
      playDownSound();
    }
  }

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
