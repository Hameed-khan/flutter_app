import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:SmartCal/dbase.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalcutor extends StatefulWidget {
  @override
  _MyCalcutorState createState() => _MyCalcutorState();
}

class _MyCalcutorState extends State<MyCalcutor> {


  @override
  //Variable
  int hour = 0;
  int mint = 0;
  String output = '0';
  String _output = '0';
  double value1 = 0;
  double value2 = 0;
  String myValue = "0";
  String fresult = "0";
  String finalres = "0";

  // DataTime for get time
  DateTime now  = new DateTime.now();

  // TODO: implement widget
  // Function for pressing  all buttons
  Widget MyButton(String value) {
    setState(() {
      //  C means clear
      if (value == "C") {
        _output = "";
        myValue = "";
        value1 = 0;
        fresult = "0";
        finalres = "0";
      }
      //square
      else if(value == "x^2") {
        value1 = double.parse(_output);
        fresult = (value1 * value1).toString();
        myValue = finishZero(fresult);
      }
      //cube
      else if(value == "x^3") {
        value1 = double.parse(_output);
        fresult = (value1 * value1 * value1).toString();
        myValue = finishZero(fresult);
      }
      //square root
      else if(value == "√") {
        value1 = double.parse(_output);

        fresult = ((value1*(1/2))).toString();
        myValue = finishZero(fresult);
      }
      //cube root
      else if(value == "∛") {
        value1 = double.parse(_output);

        fresult = ((value1*(1/3))).toStringAsFixed(3);

        myValue = finishZero(fresult);
      }
      // pressing equal button
      else if(value == "=") {
        try{
          output = _output;
          // replace because it's know for multiplication this * sign
          output = _output.replaceAll("x", "*");
          // Dart expression.
          // The blow code only work basic thing (+,-,*,/)
          Parser p = new Parser();
          Expression exp = p.parse(output);
          ContextModel cm = ContextModel();
          fresult = '${exp.evaluate(EvaluationType.REAL,cm )}';
          // Finishing floating Zero
          myValue=finishZero(fresult);


        }  // end of try
        catch(e)
        {
          myValue = "error";
        } // end of catch

      }  // end of =
      else if(value == "⩥")
      {
        _output = _output.substring(0,_output.length-1);
      } // end of back sign
      else
      {
        if(_output == "0")
        {
          _output = value;
        }
        else{
          _output = _output + value;
        }
      }

    });
  }
  // This function is used for finish zero after floating point
  String finishZero(String v)
  {
    if(v.contains('.')) {
      List<String> splitDecimal = v.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return v = splitDecimal[0].toString();
    }

    return v;

  }
  // Database instance
  final dbhelper = Databasehelper.instance;
  // This function is used for inserting values in database
  void insertData() async{
    hour= now.hour;
    mint = now.minute;
    Map<String,dynamic > row =
    {
      Databasehelper.columnColcution:_output,
      Databasehelper.columnFinalResult: myValue,
      Databasehelper.columnTime:hour,
      Databasehelper.columnTimeMin:mint
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  // This function is used for printing all button
  Widget OutButton(String text,Color color,Color textColor,double value) {
    return  Container(
      height: value,
      width: 90,
      child: FlatButton(
          shape: Border.all(color:Colors.grey[500],width: 0.1),
          color: color,
          child: Text("$text",style: TextStyle(fontSize: 25,color: textColor,fontFamily: "Roboto",fontWeight: FontWeight.w400),),
          onPressed:(){
            MyButton(text);
          }
      ),
    );

  }

  // Main contant is start
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child:Column(
            children: [
              // This for equation
              Padding(
                padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                child: Text("$_output",style: TextStyle(fontSize: 30),),
              ),
              // it's for Answer
              Padding(
                padding: const EdgeInsets.fromLTRB(180,0,0,0),
                child: Text("$myValue" ,style: TextStyle(fontSize: 60),),
              ),

            ],
          ),

        ),
        Container(
          child: Row(
            children: [
              // Passing value to function for Printing Button
              Column(
                children: [
                  OutButton("√",Colors.grey[100],Colors.grey[500],80),
                  OutButton("C",Colors.grey[100],Colors.blue[600],80),
                  OutButton("7",Colors.white,Colors.black,80),
                  OutButton("4",Colors.white,Colors.black,80),
                  OutButton("1",Colors.white,Colors.black,80),
                  OutButton("%",Colors.white,Colors.black,80),
                ],
              ),
              Column(
                children: [
                  OutButton("∛",Colors.grey[100],Colors.grey[500],80),
                  OutButton("/",Colors.grey[100],Colors.blue[600],80),
                  OutButton("8",Colors.white,Colors.black,80),
                  OutButton("5",Colors.white,Colors.black,80),
                  OutButton("2",Colors.white,Colors.black,80),
                  OutButton("0",Colors.white,Colors.black,80),
                ],
              ),
              Column(
                children: [
                  OutButton("x^2",Colors.grey[100],Colors.grey[500],80),
                  OutButton("x",Colors.grey[100],Colors.blue[600],80),
                  OutButton("9",Colors.white,Colors.black,80),
                  OutButton("6",Colors.white,Colors.black,80),
                  OutButton("3",Colors.white,Colors.black,80),
                  OutButton(".",Colors.white,Colors.black,80),
                ],
              ),
              Column(
                children: [
                  //it's button is used for insert Data in databse
                  Container(
                    height: 80,
                    width: 90,
                    child:  FlatButton(
                        shape: Border.all(color:Colors.grey[500],width: 0.1),
                        color: Colors.grey[100],
                        child: Text("Id",style: TextStyle(fontSize: 25,color: Colors.grey[500],fontWeight:FontWeight.w400,fontFamily: "Roboto",),),
                        onPressed:(){
                          insertData();
                        }
                    ),
                  ),
                  OutButton("⩥",Colors.grey[100],Colors.blue[600],80),
                  OutButton("-",Colors.grey[100],Colors.blue[600],80),
                  OutButton("+",Colors.grey[100],Colors.blue[600],80),
                  OutButton("=",Colors.blue,Colors.white,160),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
