import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scientific Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Scientific Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X" ||
        buttonText == "sin" ||
        buttonText == "cos" ||
        buttonText == "tan" ||
        buttonText == "√" ||
        buttonText == "log") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "d/dx") {
      _output = "d/dx($output)";
    } else if (buttonText == "∫") {
      _output = "∫($output)";
    } else if (buttonText == "(") {
      _output = "$output$buttonText";
    } else if (buttonText == ")") {
      _output = "$output$buttonText";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "X") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      } else if (operand == "sin") {
        _output = math.sin(num1).toString();
      } else if (operand == "cos") {
        _output = math.cos(num1).toString();
      } else if (operand == "tan") {
        _output = math.tan(num1).toString();
      } else if (operand == "√") {
        _output = math.sqrt(num1).toString();
      } else if (operand == "log") {
        _output = math.log(num1).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      output = double.parse(_output).remainder(1) == 0
          ? double.parse(_output).toInt().toString()
          : double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: OutlinedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
            backgroundColor: MaterialStateProperty.all<Color?>(color),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor ?? Colors.black),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blueGrey[800],
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
              color: Colors.white54,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton("sin", textColor: Colors.green),
                      buildButton("cos", textColor: Colors.green),
                      buildButton("tan", textColor: Colors.green),
                      buildButton("/", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("7"),
                      buildButton("8"),
                      buildButton("9"),
                      buildButton("X", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("4"),
                      buildButton("5"),
                      buildButton("6"),
                      buildButton("-", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("1"),
                      buildButton("2"),
                      buildButton("3"),
                      buildButton("+", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("√", textColor: Colors.green),
                      buildButton("0"),
                      buildButton(".", textColor: Colors.white),
                      buildButton("=", color: Colors.green),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("log", textColor: Colors.green),
                      buildButton("d/dx", textColor: Colors.green),
                      buildButton("∫", textColor: Colors.green),
                      buildButton("(", textColor: Colors.green),
                      buildButton(")", textColor: Colors.green),
                      buildButton("CLEAR", color: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
