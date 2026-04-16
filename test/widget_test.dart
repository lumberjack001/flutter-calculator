import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_calculator/main.dart';

void main() {
  group('CalculatorApp', () {
    testWidgets('renders the calculator screen', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      expect(find.byType(CalculatorScreen), findsOneWidget);
    });

    testWidgets('initial display shows 0', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('tapping a digit updates the display', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      expect(find.text('5'), findsWidgets);
    });

    testWidgets('addition: 3 + 4 = 7', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '3'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '4'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '='));
      await tester.pump();
      expect(find.text('7'), findsWidgets);
    });

    testWidgets('subtraction: 9 − 3 = 6', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '9'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '−'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '3'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '='));
      await tester.pump();
      expect(find.text('6'), findsWidgets);
    });

    testWidgets('multiplication: 4 × 5 = 20', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '4'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '×'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '='));
      await tester.pump();
      expect(find.text('20'), findsWidgets);
    });

    testWidgets('division: 8 ÷ 2 = 4', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '8'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '2'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '='));
      await tester.pump();
      expect(find.text('4'), findsWidgets);
    });

    testWidgets('division by zero shows Error', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '0'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '='));
      await tester.pump();
      expect(find.text('Error'), findsWidgets);
    });

    testWidgets('AC clears the display', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '7'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'AC'));
      await tester.pump();
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('decimal point works: 1.5 + 1.5 = 3', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '1'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '.'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '1'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '.'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '='));
      await tester.pump();
      expect(find.text('3'), findsWidgets);
    });

    testWidgets('percent button divides by 100', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '0'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '%'));
      await tester.pump();
      expect(find.text('0.5'), findsWidgets);
    });

    testWidgets('+/- button toggles sign', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '+/-'));
      await tester.pump();
      expect(find.text('-5'), findsWidgets);
    });

    testWidgets('backspace removes last digit', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '1'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '2'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '⌫'));
      await tester.pump();
      expect(find.text('1'), findsWidgets);
    });

    testWidgets('backspace resets to 0 on last digit', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '⌫'));
      await tester.pump();
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('backspace on negative number resets to 0 if only sign remains', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '+/-'));
      await tester.pump();
      // display is '-5'; backspace -> '-' is invalid -> should show '0'
      await tester.tap(find.widgetWithText(ElevatedButton, '⌫'));
      await tester.pump();
      expect(find.text('0'), findsWidgets);
    });
      await tester.pumpWidget(const CalculatorApp());
      await tester.tap(find.widgetWithText(ElevatedButton, '2'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, '3'));
      await tester.pump();
      // pressing × should chain: 2+3=5, then 5×
      await tester.tap(find.widgetWithText(ElevatedButton, '×'));
      await tester.pump();
      expect(find.text('5'), findsWidgets);
    });
  });
}
