import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "←") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget button(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 35.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 35.0),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        button('C', 1.0, Colors.redAccent),
                        button('←', 1.0, Colors.blueAccent),
                        button('^', 1.0, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('7', 1.0, Colors.black45),
                        button('8', 1.0, Colors.black45),
                        button('9', 1.0, Colors.black45),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('4', 1.0, Colors.black45),
                        button('5', 1.0, Colors.black45),
                        button('6', 1.0, Colors.black45),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('1', 1.0, Colors.black45),
                        button('2', 1.0, Colors.black45),
                        button('3', 1.0, Colors.black45),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('.', 1.0, Colors.black45),
                        button('0', 1.0, Colors.black45),
                        button('00', 1.0, Colors.black45),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        button('x', 1.0, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('÷', 1.0, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('-', 1.0, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('+', 1.0, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('=', 1.0, Colors.blueAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
