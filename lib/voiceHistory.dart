import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './dbVoice.dart';


void main()=>{runApp(MaterialApp(
  home: History(),
))};

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final dbhelp3 = Databasehelp.instance;
  void delete() async{
    var id = await dbhelp3.deletedata(3);
    print(id);
  }

  var myiteam= new List();
  List<Widget> children = new List<Widget>();
  Future<bool> queryal() async{


    var allrows = await dbhelp3.queryallrows();
    allrows.forEach((rowvl) {

      myiteam.add(rowvl);
      print(rowvl);
      children.add( Text("Time:" +rowvl['hour'].toString() + ":" + rowvl['mint'].toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.w100),));
      children.add(Text("Solving P:" + rowvl['solveResult'],style: TextStyle(fontSize: 30,fontWeight:FontWeight.w300),));
      children.add(Text("Result:" + rowvl['finalResult'].toString(),style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600),),);
    });
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 400,
            height: 50,
            child: RaisedButton(

                child:Text("Click for Record",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200),),color: Colors.grey[100],onPressed: queryal),
          ),
          Column(
            children:children,
          ),
          RaisedButton(child:Text("Delete Record"),onPressed: delete),
        ],

      ),
    );

  }
}
