import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> symbols = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '.',
    '0',
    'Ans',
    '='
  ];
  String input = "0";
  String output = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calculate, color: Colors.white), // Calculator icon
            SizedBox(width: 10), // Space between icon and text
            Text(
              "Calculator",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                input,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                output,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: symbols.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (symbols[index] == 'C') {
                      setState(() {
                        input = '';
                        output = '';
                      });
                    } else if (symbols[index] == 'Del') {
                      setState(() {
                        input = input.substring(0, input.length - 1);
                      });
                    } else if (symbols[index] == 'Ans') {
                      setState(() {
                        input = output;
                        output = '';
                      });
                    } else if (symbols[index] == '+' ||
                        symbols[index] == '-' ||
                        symbols[index] == '*' ||
                        symbols[index] == '/' ||
                        symbols[index] == '%') {
                      if (input.endsWith('%') ||
                          input.endsWith('/') ||
                          input.endsWith('-') ||
                          input.endsWith('+') ||
                          input.endsWith('*')) {
                      } else {
                        setState(() {
                          input += symbols[index];
                        });
                      }
                    } else if (symbols[index] == "=") {
                      Expression exp = Parser().parse(input);
                      double res =
                          exp.evaluate(EvaluationType.REAL, ContextModel());
                      setState(() {
                        output = res.toString();
                      });
                    } else {
                      setState(() {
                        input += symbols[index];
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: myBackground(symbols[index]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Text(
                      symbols[index],
                      style: TextStyle(
                          color: myTextColor(symbols[index]),
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Color myBackground(String s) {
    if (s == 'C') {
      return Colors.teal.shade400;
    } else if (s == 'Del') {
      return Colors.red;
    } else if (s == '%' ||
        s == '/' ||
        s == '+' ||
        s == '*' ||
        s == '-' ||
        s == '=') {
      return Colors.blueAccent;
    } else {
      return Colors.grey.shade300;
    }
  }

  Color myTextColor(String s) {
    if (s == '%' ||
        s == '/' ||
        s == '+' ||
        s == '*' ||
        s == '-' ||
        s == '=' ||
        s == 'C' ||
        s == 'Del') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
