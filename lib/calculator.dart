import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  Widget buildButton(String btnText, double btnHeight, Color btnColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      color: btnColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => handleInput(btnText),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  handleInput(String btnText) {
    setState(() {
      if (btnText == "C") {
        equation = "0";
        result = "0";
      } else if (btnText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") equation = "0";
      } else if (btnText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0")
          equation = btnText;
        else
          equation = equation + btnText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          //EXPRESSIONS AND EQUATIONS
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: 30),
              )),
          //RESULT
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: 40),
              )),

          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.redAccent),
                        buildButton("%", 1, Colors.lightGreen),
                        buildButton("÷", 1, Colors.lightGreen),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.grey),
                        buildButton("8", 1, Colors.grey),
                        buildButton("9", 1, Colors.grey),
                        buildButton("×", 1, Colors.lightGreen),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.grey),
                        buildButton("5", 1, Colors.grey),
                        buildButton("6", 1, Colors.grey),
                        buildButton("-", 1, Colors.lightGreen),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.grey),
                        buildButton("2", 1, Colors.grey),
                        buildButton("3", 1, Colors.grey),
                        buildButton("+", 1, Colors.lightGreen),
                      ]),
                      TableRow(children: [
                        buildButton("00", 1, Colors.grey),
                        buildButton("0", 1, Colors.grey),
                        buildButton(".", 1, Colors.grey),
                        buildButton("=", 1, Colors.lightGreen),
                      ]),
                    ],
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
