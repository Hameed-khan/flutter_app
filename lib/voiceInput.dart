import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import './dbVoice.dart';
void main()=>{runApp(MApp())};

class MApp extends StatefulWidget {
  @override
  _MAppState createState() => _MAppState();
}

class _MAppState extends State<MApp> {

  // creating single instance and we can used in mutliples widget
  //we need instance of speechtotext variable
  SpeechToText  stt = SpeechToText();
  //we need variable if we are listening or not
  bool isListening = true;
  String finalValueResult = "";
  double num1 = 0.0;
  String question = "0";
  double num2 = 0.0;
  String value = "";
  int hour = 0;
  int mint = 0;
  //for showing text on the output
  String text = "";
  double accuracy = 1.0;
  DateTime now  = new DateTime.now();
  final dbhelp = Databasehelp.instance;
  void insertData() async{
    hour= now.hour;
    mint = now.minute;
    Map<String,dynamic > row =
    {
      Databasehelp.columnEquestion:question,
      Databasehelp.columnResult:finalValueResult,
      Databasehelp.columnTime:hour,
      Databasehelp.columnTimeMin:mint
    };
    final id = await dbhelp.insert(row);
    print(id);
  }
  @override
  //we need initialize function to initialize our speech to text plugin
  void iniState()async
  {
    // initialize our audio
    initializeAudio();
    //defualt
    super.initState();
  }
  //this is used for initialize out audio
  initializeAudio()async{
    stt.initialize();
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          //we add for we will be able to add more and more text
          reverse: true,
          child: Container(
            child:Column(
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(text,style: TextStyle(fontSize: 40,fontWeight: FontWeight.w300),),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                  child: Text("Answer = " + finalValueResult,style: TextStyle(fontSize: 40,fontWeight: FontWeight.w300)),
                ),
              ],
            ),
          ),
        ),

        FloatingActionButton(
          // this is calling out _listening function
          onPressed: _listen,
          tooltip: "Increment",
          child: Icon(
              isListening?Icons.add:Icons.play_circle_fill
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0,25,0,4),
          child:Text("Pressed on button Calculate value",style: TextStyle(fontSize: 18),),),
        MaterialButton(color:Colors.blue[500],child: Text("Voice History"),
            onPressed:(){
              insertData();

            } ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.add, size: 45),
                title: Text('Addition'),
                subtitle: Text('For addition the plus sign is used'),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.remove, size: 45),
                title: Text('Subtraction'),
                subtitle: Text('For subtraction the minus is used'),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.double_arrow_sharp, size: 45),

                title: Text('divide'),
                subtitle: Text('divide is used for division '),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.backspace_sharp, size: 45),

                title: Text('X'),
                subtitle: Text('X is used for multplication '),
              ),
            ],
          ),
        ),
      ],

    );

  }
  //this listen is give if user give permission listening it start record and listening and do not give permission i will be not record and listining
  _listen()async{
    //first step user is give permission
    //isAvailable means the user is give permission it will preparely  initialize
    if(stt.isAvailable)
    {
      // check it is listening or not. if it is not listening i will be need for starting listening
      if(!isListening)
      {
        stt.listen(onResult: (result){
          setState(() {
            //it for checking the accuracy of it
            accuracy = result.confidence;
            // it for assign text to text
            text = result.recognizedWords;
            myMathFunction(text);
            print("accuracy is $accuracy");
            isListening = true;
          });
        });
      }
      else
      {
        setState(() {
          isListening = false;
          stt.stop();
        });
      }
    }
    //user is not give permission
    else
    {
      print("permission was deniad");
    }
  }
  String myMathFunction(String text) {
    if (text.contains("+"))
    {
      List<String> splitString = text.toString().split("+");
      num1 = double.parse(splitString[0]);
      num2 = double.parse(splitString[1]);
      question = num1.toString() + '+' + num2.toString();
      value = (num1 + num2).toString();
      finalValueResult = finishZero(value);
      print(finalValueResult);
    }
    else if(text.contains("-"))
    {
      List<String> splitString = text.toString().split("-");
      num1 = double.parse(splitString[0]);
      num2 = double.parse(splitString[1]);
      question = num1.toString() + '-' + num2.toString();
      value = (num1 - num2).toString();
      finalValueResult = finishZero(value);
      print(finalValueResult);
    }
    else if(text.contains("divide"))
    {
      List<String> splitString = text.toString().split("divide");
      num1 = double.parse(splitString[0]);
      num2 = double.parse(splitString[1]);
      question = num1.toString() + '/' + num2.toString();
      value = (num1 / num2).toString();
      finalValueResult = finishZero(value);
      print(finalValueResult);
    }
    else if(text.contains("x"))
    {
      List<String> splitString = text.toString().split("x");
      num1 = double.parse(splitString[0]);
      num2 = double.parse(splitString[1]);
      question = num1.toString() + 'x' + num2.toString();
      value = (num1 * num2).toString();
      finalValueResult = finishZero(value);
      print(finalValueResult);
    }

  }
  String finishZero(String v)
  {
    if(v.contains('.')) {
      List<String> splitDecimal = v.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return v = splitDecimal[0].toString();
    }

    return v;

  }
}