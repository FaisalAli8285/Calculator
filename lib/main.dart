import 'dart:math';

import 'package:calculator/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  num firstnum = 0.0;
  num secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 24.0;
  onbuttonpressed(value) {
    if (value == "AC") {
      input = '';
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);//use The substring of this string from [start],
        // inclusive, to [end], exclusive.(it remove the value from string)
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        input = output;
        hideInput = true;
        outputSize = 40;
      }
    } else {
      input = input + value;
       hideInput = false;
      outputSize = 24;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(//represent outputscreen
            padding: EdgeInsets.all(12),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
               
                Text(
                  hideInput ? "" : input,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                
                Text(
                  output,
                  style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7)),
                ),
                
              ],
            ),
          )),
          //button area
          Row(
            children: [
              button(text: "AC", tcolor: Colors.orange),
              button(text: "<", buttonbgcolor: operatorColor),
              button(text: "", tcolor: Colors.transparent),
              button(text: "/", buttonbgcolor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x", buttonbgcolor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", buttonbgcolor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonbgcolor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "%", buttonbgcolor: operatorColor),
              button(text: "0"),
              button(text: ".", buttonbgcolor: operatorColor),
              button(text: "=", buttonbgcolor: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,//get text
    tcolor = Colors.white,//get text color
    buttonbgcolor = buttonColor,//get button color
  }) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onbuttonpressed(text),//function call
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: tcolor),
          ),
        ),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(22),
            primary: buttonbgcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
      ),
    ));
  }
}
