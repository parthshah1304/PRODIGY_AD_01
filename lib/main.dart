import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _equation = "0";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _equation = "0";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      if (_operand.isEmpty) {
        _num1 = double.parse(_equation);
      } else {
        _num2 = double.parse(_equation.split(_operand).last);
        _num1 = _performOperation();
        _num2 = 0.0;
      }
      _operand = buttonText;
      _equation += buttonText;
      _output = _num1.toString();
    } else if (buttonText == ".") {
      if (_equation.contains(".")) {
        return;
      } else {
        _equation += buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_equation.split(_operand).last);
      _output = _performOperation().toString();
      _equation = _output;
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else {
      if (_equation == "0") {
        _equation = buttonText;
      } else {
        _equation += buttonText;
      }
      _output = _equation;
    }

    setState(() {
      _output = double.tryParse(_equation) != null ? double.parse(_equation).toString() : _equation;
    });
  }

  double _performOperation() {
    switch (_operand) {
      case "+":
        return _num1 + _num2;
      case "-":
        return _num1 - _num2;
      case "*":
        return _num1 * _num2;
      case "/":
        return _num2 != 0.0 ? _num1 / _num2 : double.nan;
      default:
        return _num1;
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Calculator')),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("C"),
                  buildButton("="),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}



