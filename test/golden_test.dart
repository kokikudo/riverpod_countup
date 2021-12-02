import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_countup/main.dart';
import 'package:riverpod_countup/view_model.dart';

/* テスト実行前に、参照スクリーンショットを作成する
flutter test --update-goldens test/golden_test.dart
*/

// Mock作成
class MockViewModel extends Mock implements ViewModel {}

void main() {
  // フォントをダウンロード
  setUpAll(() async {
    await loadAppFonts();
  });

  const iPhone55 = Device(
    size: Size(414, 736),
    name: 'iPhone55',
    devicePixelRatio: 3.0,
  );

  List<Device> devices = [iPhone55];

  testGoldens('normal', (tester) async {
    ViewModel viewModel = ViewModel();

    // Widgetsをpump(抽出)する
    await tester.pumpWidgetBuilder(
      ProviderScope(
        child: MyHomePage(viewModel),
      ),
    );

    // ゴールデン（正解用）スクリーンショットとpumpしたスクリーンを比較
    await multiScreenGolden(
      tester,
      'myHomePage_0init',
      devices: devices,
    );

    // 何回かボタンを押して再度テストする
    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.tap(find.byIcon(CupertinoIcons.minus));
    await multiScreenGolden(tester, 'myHopePage_tapped', devices: devices);
  });

  // // Mockを使ったテスト方法
  // testGoldens('viewModelTest', (tester) async {
  //   // ViewModelのモックを生成
  //   var mock = MockViewModel();
  //   // 手を加えたい変数とその戻り値を設定
  //   when(() => mock.count).thenReturn(1123456789.toString());
  //   when(() => mock.countUp).thenReturn(21123456789.toString());
  //   when(() => mock.countDown).thenReturn(31123456789.toString());

  //   await tester.pumpWidgetBuilder(
  //     ProviderScope(
  //       child: MyHomePage(mock),
  //     ),
  //   );
  //   await multiScreenGolden(
  //     tester,
  //     'myHomePage_mock',
  //     devices: devices,
  //   );

  //   // ボタンが押されたかどうかの確認
  //   await tester.tap(find.byIcon(CupertinoIcons.plus));
  //   verify(() => mock.onIncrease()).called(1); // 一回押されたか確認
  //   verifyNever(() => mock.onDecrease()); // 一度も押されてないか確認
  //   verifyNever(() => mock.onReset());

  //   // マイナスボタンを押してみる
  //   // 一度calledされたら初期化されるのでonIncrease()は押されてないことになる
  //   await tester.tap(find.byIcon(CupertinoIcons.minus));
  //   await tester.tap(find.byIcon(CupertinoIcons.minus));
  //   verifyNever(() => mock.onIncrease());
  //   verifyNever(() => mock.onDecrease());
  //   verifyNever(() => mock.onReset());

  //   // リフレッシュボタンで全てのカウントが0になっているか確認
  //   await tester.tap(find.byIcon(Icons.refresh));
  //   verifyNever(() => mock.onIncrease());
  //   verifyNever(() => mock.onDecrease());
  //   verifyNever(() => mock.onReset());
  //});
}
