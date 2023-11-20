import 'package:calculadora/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double num1 = 0.0;
  double num2 = 0.0;

  var input = '';
  var output = '';
  var operation = '';
  bool hideInput = false;

  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
      operation = '';
    }else if(value == '='){
      if(input.isNotEmpty){
        var auxInput = input;
        auxInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(auxInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();

        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
      }
    }else{
      input += value;
      hideInput = false;
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: TextStyle(fontSize: 40, color: hideInput ? primayColor : Colors.white),
                    ),
                    Text(
                      output,
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    )
                  ],
                ),
              )),

              // LINHA DE ICONS
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.query_builder,
                                color: Colors.grey.withOpacity(0.8),
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.straighten_rounded,
                                color: Colors.grey.withOpacity(0.8),
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.calculate_outlined,
                                color: Colors.grey.withOpacity(0.8),
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (input.isNotEmpty) {
                            input = input.substring(0, input.length - 1);
                            setState(() {
                              
                            });
                          }
                        },
                        icon: Icon(
                          CupertinoIcons.delete_left,
                          color: Colors.green,
                          size: 15,
                        )),
                  ],
                ),
              ),

              // LINHA DE DIVISÃO
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.5),
                  )),

              // Buttons
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: button(
                                        text: 'C',
                                        tColor: Colors.red.shade300)),
                                Expanded(
                                    child: button(
                                        text: '( )', tColor: primayColor)),
                                Expanded(
                                    child:
                                        button(text: '%', tColor: primayColor)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: button(text: '7')),
                                Expanded(child: button(text: '8')),
                                Expanded(child: button(text: '9')),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: button(text: '4')),
                                Expanded(child: button(text: '5')),
                                Expanded(child: button(text: '6')),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: button(text: '1')),
                                Expanded(child: button(text: '2')),
                                Expanded(child: button(text: '3')),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: button(text: '+/-')),
                                Expanded(child: button(text: '0')),
                                Expanded(child: button(text: ',')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          button(text: '/', tColor: primayColor, bsize: 30),
                          button(text: 'x', tColor: primayColor, bsize: 30),
                          button(text: '-', tColor: primayColor, bsize: 30),
                          button(text: '+', tColor: primayColor, bsize: 30),
                          button(text: '=', bckColor: primayColor, bsize: 30),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget button(
    {text,
    tColor = Colors.white,
    bckColor = buttonBckColor,
    double bsize = 22}) {
  return Container(
    margin: EdgeInsets.all(4),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(60, 60),
          shape: CircleBorder(),
          backgroundColor: bckColor),
      onPressed: () => onButtonClick(text),
      child: Text(
        text,
        style: TextStyle(fontSize: bsize, color: tColor),
      ),
    ),
  );
}

}

