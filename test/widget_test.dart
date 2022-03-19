// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sample/main.dart';
import 'package:flutter_sample/detail_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';


@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigatorObserver>(
      returnNullOnMissingStub: true,
    )
  ],
)
void main() {

  testWidgets('app widgets test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (context) => const MyHomePage(title: 'Test Model List'),
          '/detail': (context) => DetailPage(),
        },
        initialRoute: "/",
        navigatorObservers: [mockObserver],
      ),
    );

    // 初期画面ではモデルが何も存在しないことを確認
    expect(find.text('Model 0'), findsNothing);

    // '+'アイコンをタップする
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // モデルが１つ追加されることを確認
    expect(find.text('Model 0'), findsOneWidget);
    expect(find.text('Model 1'), findsNothing);
    expect(find.text('Model 2'), findsNothing);

    // '+'アイコンを2回タップする
    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // モデルが２つ追加されて合計３つになることを確認
    expect(find.text('Model 0'), findsOneWidget);
    expect(find.text('Model 1'), findsOneWidget);
    expect(find.text('Model 2'), findsOneWidget);
    expect(find.text('Model 3'), findsNothing);

    // モデル1をタップする
    await tester.tap(find.text('Model 1'));
    await tester.pumpAndSettle();

    // Navigationイベント(画面遷移)が発生することを確認
    verify(mockObserver.didPush(any, any));

    // DetailPageに遷移していることを確認
    expect(find.byType(MyHomePage), findsNothing);
    expect(find.byType(DetailPage), findsOneWidget);

    // モデル1の情報が表示されていることを確認
    expect(find.text('Model 1'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);

    // Removeボタンを押す
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();

    // Navigationイベント(元の画面に戻る)が発生することを確認
    verify(mockObserver.didPop(any, any));

    // MyHomePageに戻っていることを確認
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(DetailPage), findsNothing);

    // モデル1が削除されていることを確認
    expect(find.text('Model 0'), findsOneWidget);
    expect(find.text('Model 1'), findsNothing);
    expect(find.text('Model 2'), findsOneWidget);

  });
}
