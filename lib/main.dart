import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "0";

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "0";
      } else if (value == "=") {
        calculateResult();
      } else {
        input += value;
      }
    });
  }

 void calculateResult() {
  try {
    String finalInput = input
        .replaceAll("×", "*")
        .replaceAll("÷", "/");

    final expression = RegExp(r'^(\d+\.?\d*)([\+\-\*/])(\d+\.?\d*)$');
    final match = expression.firstMatch(finalInput);

    if (match != null) {
      double num1 = double.parse(match.group(1)!);
      String operator = match.group(2)!;
      double num2 = double.parse(match.group(3)!);

      double calcResult;

      switch (operator) {
        case "+":
          calcResult = num1 + num2;
          break;
        case "-":
          calcResult = num1 - num2;
          break;
        case "*":
          calcResult = num1 * num2;
          break;
        case "/":
          if (num2 == 0) {
            result = "Cannot divide by 0";
            return;
          }
          calcResult = num1 / num2;
          break;
        default:
          result = "Error";
          return;
      }

      setState(() {
        result = calcResult.toString();
        input = ""; // Clear input after showing result
      });
    } else {
      setState(() {
        result = "Invalid Input";
      });
    }
  } catch (e) {
    setState(() {
      result = "Error";
    });
  }
}


  Widget buildButton(String text,
      {Color bgColor = Colors.grey, Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                input.isEmpty ? result : input,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("C", bgColor: Colors.red),
                  buildButton("0"),
                  buildButton("=",
                      bgColor: Colors.green, textColor: Colors.white),
                  buildButton("+", bgColor: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
