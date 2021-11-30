import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_countup/logic/logic.dart';
import 'package:riverpod_countup/logic/sound_logic.dart';

import 'provider.dart';

// ロジックを実行し、結果をViewに返すためのクラス
// プロパティに各ロジックのインスタンス、プロバイダーリファレンスを定義
class ViewModel {
  final Logic _logic = Logic();
  final SoundLogic _soundLogic = SoundLogic();
  late WidgetRef ref;

  void setRef(WidgetRef ref) {
    this.ref = ref;
    // 音声の読み込み
    _soundLogic.load();
  }

  get count => ref.watch(countDataProvider).count.toString();
  // get countUp => ref.watch(countDataProvider.select((value) {
  //       debugPrint('countUpが再描画されたよ');
  //       return value.countUp;
  //     })).toString();
  // get countDown => ref.watch(countDataProvider.select((value) {
  //       debugPrint('countDownが再描画されたよ');
  //       return value.countDown;
  //     })).toString();

  get countUp =>
      ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();
    ref.watch(countDataProvider.state).update((state) => _logic.countData);
    _soundLogic.playUpSound();
  }

  void onDecrease() {
    _logic.decrease();
    ref.watch(countDataProvider.state).update((state) => _logic.countData);
    _soundLogic.playDownSound();
  }

  void onReset() {
    _logic.reset();
    ref.watch(countDataProvider.state).update((state) => _logic.countData);
    _soundLogic.playResetSound();
  }
}
