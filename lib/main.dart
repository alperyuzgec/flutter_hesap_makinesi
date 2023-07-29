import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";
  bool _isOperatorClicked = false;

  void _onNumberClick(String buttonText) {
    if (_output == "0" || _isOperatorClicked) {
      setState(() {
        _output = buttonText;
        _isOperatorClicked = false;
      });
    } else {
      setState(() {
        _output += buttonText;
      });
    }
  }

  void _onOperatorClick(String buttonText) {
    if (_operator.isNotEmpty) {
      _onEqualClick();
    }

    setState(() {
      _num1 = double.parse(_output);
      _operator = buttonText;
      _isOperatorClicked = true;
    });
  }

  void _onEqualClick() {
    setState(() {
      _num2 = double.parse(_output);

      switch (_operator) {
        case "+":
          _output = (_num1 + _num2).toString();
          break;
        case "-":
          _output = (_num1 - _num2).toString();
          break;
        case "*":
          _output = (_num1 * _num2).toString();
          break;
        case "/":
          _output = (_num1 / _num2).toString();
          break;
        default:
          break;
      }

      _num1 = double.parse(_output);
      _operator = "";

      // Sonucun ondalık kısmı kontrol edilir
      // Ondalık kısım yoksa sonuç tam sayıya çevrilir
      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  void _onClearClick() {
    setState(() {
      _output = "0";
      _num1 = 0;
      _num2 = 0;
      _operator = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Makinesi"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildButtonRow(["7", "8", "9", "/"], Colors.orange),
            SizedBox(height: 8),
            _buildButtonRow(["4", "5", "6", "*"], Colors.orange),
            SizedBox(height: 8),
            _buildButtonRow(["1", "2", "3", "-"], Colors.orange),
            SizedBox(height: 8),
            _buildButtonRow(["0", "C", "=", "+"], Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonLabels, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          buttonLabels.map((label) => _buildButton(label, color)).toList(),
    );
  }

  Widget _buildButton(String buttonText, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: buttonText == "C"
            ? _onClearClick
            : buttonText == "="
                ? _onEqualClick
                : (buttonText == "+" ||
                        buttonText == "-" ||
                        buttonText == "*" ||
                        buttonText == "/")
                    ? () => _onOperatorClick(buttonText)
                    : () => _onNumberClick(buttonText),
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
