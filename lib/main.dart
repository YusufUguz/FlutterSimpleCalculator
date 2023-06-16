// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.red),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(
      () {
        if (buttonText == "C") {
          equation = "0";
          result = "0";
          equationFontSize = 38;
          resultFontSize = 48;
        } else if (buttonText == "DEL") {
          equationFontSize = 48;
          resultFontSize = 38;
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") {
            equation = "0";
          }
        } else if (buttonText == "=") {
          equationFontSize = 38;
          resultFontSize = 48;
          expression = equation;
          expression = expression.replaceAll("x", "*");
          expression = expression.replaceAll("÷", "/");

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = "Error";
          }
        } else {
          equationFontSize = 48;
          resultFontSize = 38;
          if (equation == "0") {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      },
    );
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
    );
  }

  Widget buildDifferentButton(String buttonText, double buttonHeight,
      Color buttonColor, Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.normal, color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Simple Calculator",
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(children: [
                  TableRow(children: [
                    buildDifferentButton("C", 1, Colors.white54, Colors.red),
                    buildDifferentButton(
                        "DEL", 1, Colors.white54, Colors.redAccent),
                    buildDifferentButton(
                        "÷", 1, Colors.white54, Colors.lightBlue),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.white54),
                    buildButton("8", 1, Colors.white54),
                    buildButton("9", 1, Colors.white54),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.white54),
                    buildButton("5", 1, Colors.white54),
                    buildButton("6", 1, Colors.white54),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.white54),
                    buildButton("2", 1, Colors.white54),
                    buildButton("3", 1, Colors.white54),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.white54),
                    buildButton("0", 1, Colors.white54),
                    buildButton("00", 1, Colors.white54),
                  ])
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(children: [
                  TableRow(children: [
                    buildDifferentButton(
                        "x", 1, Colors.white54, Colors.lightBlue)
                  ]),
                  TableRow(children: [
                    buildDifferentButton(
                        "-", 1, Colors.white54, Colors.lightBlue)
                  ]),
                  TableRow(children: [
                    buildDifferentButton(
                        "+", 1, Colors.white54, Colors.lightBlue)
                  ]),
                  TableRow(children: [
                    buildDifferentButton(
                        "=", 2, Colors.white54, Colors.lightBlue)
                  ]),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
