import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _expression = '';
  double _firstOperand = 0;
  String _operator = '';
  bool _waitingForSecondOperand = false;

  void _onDigitPressed(String digit) {
    setState(() {
      if (_waitingForSecondOperand) {
        _display = digit;
        _waitingForSecondOperand = false;
      } else {
        _display = _display == '0' ? digit : _display + digit;
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_waitingForSecondOperand) {
        _display = '0.';
        _waitingForSecondOperand = false;
        return;
      }
      if (!_display.contains('.')) {
        _display = '$_display.';
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      final double currentValue = double.tryParse(_display) ?? 0;
      if (_operator.isNotEmpty && !_waitingForSecondOperand) {
        final double result = _calculate(_firstOperand, currentValue, _operator);
        _display = _formatResult(result);
        _firstOperand = result;
      } else {
        _firstOperand = currentValue;
      }
      _operator = operator;
      _expression = '${_formatResult(_firstOperand)} $operator';
      _waitingForSecondOperand = true;
    });
  }

  void _onEqualsPressed() {
    setState(() {
      if (_operator.isEmpty) return;
      final double secondOperand = double.tryParse(_display) ?? 0;
      final double result = _calculate(_firstOperand, secondOperand, _operator);
      _expression = '${_expression} ${_formatResult(secondOperand)} =';
      _display = _formatResult(result);
      _operator = '';
      _firstOperand = result;
      _waitingForSecondOperand = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _expression = '';
      _firstOperand = 0;
      _operator = '';
      _waitingForSecondOperand = false;
    });
  }

  void _onToggleSignPressed() {
    setState(() {
      final double value = double.tryParse(_display) ?? 0;
      _display = _formatResult(-value);
    });
  }

  void _onPercentPressed() {
    setState(() {
      final double value = double.tryParse(_display) ?? 0;
      _display = _formatResult(value / 100);
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_display.length > 1) {
        final String trimmed = _display.substring(0, _display.length - 1);
        // If what remains is not a valid number (e.g. '-' or '.'), reset to '0'
        final double? parsed = double.tryParse(trimmed);
        _display = (parsed != null) ? trimmed : '0';
      } else {
        _display = '0';
      }
    });
  }

  double _calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '−':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) return double.nan;
        return a / b;
      default:
        return b;
    }
  }

  String _formatResult(double value) {
    if (value.isNaN) return 'Error';
    if (value.isInfinite) return 'Error';
    if (value == value.truncateToDouble()) {
      final int intVal = value.toInt();
      return intVal.toString();
    }
    String result = value.toStringAsFixed(10);
    result = result.replaceAll(RegExp(r'0+$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildDisplay(),
            ),
            _buildButtonGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _expression,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            _display,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.w300,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGrid() {
    return Column(
      children: [
        _buildButtonRow([
          _CalcButton(label: 'AC', onPressed: _onClearPressed, type: ButtonType.function),
          _CalcButton(label: '⌫', onPressed: _onBackspacePressed, type: ButtonType.function),
          _CalcButton(label: '%', onPressed: _onPercentPressed, type: ButtonType.function),
          _CalcButton(label: '÷', onPressed: () => _onOperatorPressed('÷'), type: ButtonType.operator),
        ]),
        _buildButtonRow([
          _CalcButton(label: '7', onPressed: () => _onDigitPressed('7'), type: ButtonType.digit),
          _CalcButton(label: '8', onPressed: () => _onDigitPressed('8'), type: ButtonType.digit),
          _CalcButton(label: '9', onPressed: () => _onDigitPressed('9'), type: ButtonType.digit),
          _CalcButton(label: '×', onPressed: () => _onOperatorPressed('×'), type: ButtonType.operator),
        ]),
        _buildButtonRow([
          _CalcButton(label: '4', onPressed: () => _onDigitPressed('4'), type: ButtonType.digit),
          _CalcButton(label: '5', onPressed: () => _onDigitPressed('5'), type: ButtonType.digit),
          _CalcButton(label: '6', onPressed: () => _onDigitPressed('6'), type: ButtonType.digit),
          _CalcButton(label: '−', onPressed: () => _onOperatorPressed('−'), type: ButtonType.operator),
        ]),
        _buildButtonRow([
          _CalcButton(label: '1', onPressed: () => _onDigitPressed('1'), type: ButtonType.digit),
          _CalcButton(label: '2', onPressed: () => _onDigitPressed('2'), type: ButtonType.digit),
          _CalcButton(label: '3', onPressed: () => _onDigitPressed('3'), type: ButtonType.digit),
          _CalcButton(label: '+', onPressed: () => _onOperatorPressed('+'), type: ButtonType.operator),
        ]),
        _buildBottomRow(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildButtonRow(List<_CalcButton> buttons) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: buttons
            .map((b) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: b,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildBottomRow() {
    return _buildButtonRow([
      _CalcButton(label: '+/-', onPressed: _onToggleSignPressed, type: ButtonType.function),
      _CalcButton(label: '0', onPressed: () => _onDigitPressed('0'), type: ButtonType.digit),
      _CalcButton(label: '.', onPressed: _onDecimalPressed, type: ButtonType.digit),
      _CalcButton(label: '=', onPressed: _onEqualsPressed, type: ButtonType.operator),
    ]);
  }
}

enum ButtonType { digit, operator, function }

class _CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;

  const _CalcButton({
    required this.label,
    required this.onPressed,
    required this.type,
  });

  Color get _backgroundColor {
    switch (type) {
      case ButtonType.operator:
        return const Color(0xFFFF9500);
      case ButtonType.function:
        return const Color(0xFFA5A5A5);
      case ButtonType.digit:
        return const Color(0xFF333333);
    }
  }

  Color get _foregroundColor {
    switch (type) {
      case ButtonType.operator:
        return Colors.white;
      case ButtonType.function:
        return Colors.black;
      case ButtonType.digit:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
