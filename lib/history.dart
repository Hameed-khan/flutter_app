import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SmartCal/dbase.dart';

class calHistory extends StatefulWidget {

  @override
  _calHistoryState createState() => _calHistoryState();
}
class _calHistoryState extends State<calHistory> {

  //  instance of database
  final dbhelper1 = Databasehelper.instance;
  // This delete function if you pass id number to it and press it will delete that record from table
  void delete() async{
    var id = await dbhelper1.deletedata(6);
    print(id);
  }
  // List for storing value
  var myiteam= new List();
  List<Widget> children = new List<Widget>();
  //Function
  Future<bool> queryall() async{
    var allrows = await dbhelper1.queryallrows();
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

    return  Scaffold(
          // For showing record
          body:  SingleChildScrollView(child:Column(
            children: [
                Container(
                  width: 400,
                  height: 50,
                  child:RaisedButton(
                    child: Text("Click show record",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.grey[500]),),
                    onPressed: (){
                      queryall();
                    },
                  ),
                ),
              // Showing record
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,140,0),
                child: SizedBox(
                  child: Column(
                        children: children,
                    ),
                ),
              ),
            //For deleting button
            Container(
              height: 60,
              width: 390,
              child:  FlatButton(
                  shape: Border.all(color:Colors.grey[500],width: 0.1),
                  color: Colors.grey[100],
                  child: Text("Delete record",style: TextStyle(fontSize: 25,color: Colors.grey[500],fontWeight:FontWeight.w400,fontFamily: "Roboto",),),
                  onPressed:(){
                    delete();
                  }
              ),
            ),




            ],
          ),

          )
          );



  }
}
