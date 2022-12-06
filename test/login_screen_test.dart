import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stockee/authentication_page/login_screen.dart';
import 'package:mockito/mockito.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  ;
  var phoneNumberField = find.byType(TextFormField);
  var nextButton = find.text("Next");
  testWidgets('Screen load properly', ((WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: LoginScreen()));
    expect(phoneNumberField, findsOneWidget);
    expect(nextButton, findsOneWidget);
  }));
}
