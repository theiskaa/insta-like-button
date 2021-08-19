import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insta_like_button/insta_like_button.dart';

void main() {
  InstaLikeButton instaLikeButton;
  late Widget mainWidget;

  setUpAll(() {
    // Initilaze instaLikeButton.
    instaLikeButton = InstaLikeButton(
      image: AssetImage("example/overview/img.jpg"),
      onChanged: () => print("Liked!"),
    );

    // Initilaze mainWidget.
    mainWidget = MaterialApp(
      title: "Insta like button",
      home: Scaffold(body: Center(child: instaLikeButton)),
    );
  });

  testWidgets('Insta like button test', (WidgetTester tester) async {
    await tester.pumpWidget(mainWidget);

    // MainWidget tests.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(3));

    // InstaLikeButton tests.
    expect(find.byType(AnimatedBuilder), findsNWidgets(5));
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(AnimatedOpacity), findsOneWidget);
  });
}
