//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String btntxt){
    setState(() {
      if(btntxt == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(btntxt == "De"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(btntxt == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = btntxt;
        }else {
          equation = equation + btntxt;
        }
      }
    });
   }

  Widget calbutton(String btntxt, Color btncolr , Color txtcolor) {
    return Container(
      child: SizedBox(
        height: 70,
        width: 90,
        child: ElevatedButton(
          onPressed: () => buttonPressed(btntxt)
          ,
          child: Text(btntxt,style: TextStyle(fontSize: 22, color: txtcolor),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
            primary: btncolr,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
//      appBar: AppBar(
//        centerTitle: true,
//        backgroundColor: Colors.black,
//        title: Text("CALCULATOR", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green ),),
//      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: Text(equation, style: TextStyle(fontSize: equationFontSize, color: Colors.white),),
                ),



              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  //alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 15, 30, 25),
                  child: Text(result, style: TextStyle(fontSize: resultFontSize, color: Colors.white),),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("C", Colors.green, Colors.black),
                calbutton("De", Colors.green, Colors.black),
                calbutton("%", Colors.green, Colors.black),
                calbutton("×", Colors.green, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("7", Colors.grey, Colors.black),
                calbutton("8", Colors.grey, Colors.black),
                calbutton("9", Colors.grey, Colors.black),
                calbutton("+", Colors.green, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("4", Colors.grey, Colors.black),
                calbutton("5", Colors.grey, Colors.black),
                calbutton("6", Colors.grey, Colors.black),
                calbutton("-", Colors.green, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("1", Colors.grey, Colors.black),
                calbutton("2", Colors.grey, Colors.black),
                calbutton("3", Colors.grey, Colors.black),
                calbutton("÷", Colors.green, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ ElevatedButton(
                  onPressed: () {
                    buttonPressed('0');
                  },
                  child: Text("0",style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.fromLTRB(30, 20, 130, 20),
                    primary: Colors.green,
                  ),
                ),
                calbutton(".", Colors.grey, Colors.black),
                calbutton("=", Colors.green, Colors.black),

              ],

            ),
          ],
        ),


      ),
    );
  }
}
