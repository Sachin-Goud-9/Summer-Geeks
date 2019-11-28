
import 'dart:convert';
import 'dart:core';
import 'package:summer_geeks/utils/database_visitor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:summer_geeks/models/regform.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'package:http/http.dart' as http;       //used for sending messages
import 'package:sqflite/sqlite_api.dart';
import 'package:summer_geeks/utils/database_host.dart';
import 'package:summer_geeks/models/reghostForm.dart';

void main(List<String> args) {
  runApp(VisitorDisplay());
}


class VisitorDisplay extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          accentColor: Colors.indigo,
          textSelectionColor: Colors.orange,
          ),
          title: 'Meet',
          home: VisitorContent(),
    );
  }
        
}


class VisitorContent extends StatelessWidget{
  
  
  
  DatabaseVisitor databaseVisitor=DatabaseVisitor();
  DatabaseHost databaseHost=DatabaseHost();
  List<RegStore> regVisitList;
  List<RegHostStore> regHostList;
  RegStore regStore;
  String name;
  
  
    Widget build(BuildContext context) {
    // TODO: implement build
    if(regVisitList==null)
    {
      regVisitList=List<RegStore>();
      regVisitList=updateListView();
    }
    if(regHostList==null)
    {
      regHostList=List<RegHostStore>();
      regHostList=updateListHostView();
    }
    //regVisitList=databaseVisitor.getNoteList();

  

    return Scaffold(
      appBar: AppBar(title: Text('Meeting'),),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Your are in a Meeting.'),
        ),
        Padding(padding: EdgeInsets.only(top:5.0,bottom: 5.0),
                  
                  child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text('Exit Meeting'),
                  elevation: 10.0,
                  onPressed: () async {
                         debugPrint("ButtonPressed");
                         debugPrint('$regVisitList');
                       
          //used for specifying message to be sent to the visitor
          DateTime dt=DateTime.now();
        String message1;
        message1='''Name: $regVisitList[0]
                   Phone: $regVisitList[1]
                   Check-in Time: $regVisitList[3]
                   Check-out Time: dt
                   Host-Name: $regHostList[0]
                   Adress-Visited: $regHostList[3]''';


        //sending email
          String username = 'sachingoud200@gmail.com';
          String password = 's@chin_goud';
          final smtpServer = mailgun(username, password);
          final message = Message()
    ..from = Address(username, 'Sachin Goud')
    ..recipients.add('$regVisitList[2]')
    ..ccRecipients.addAll(['sachingoud200@gmail.com', 'sachingoud200@gmail.com'])
    ..bccRecipients.add(Address('sachingoud200@gmail.com'))
    ..subject = 'Test Dart Mailer library :: 😀 :: '
    ..text = message1
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    
    final sendReports = await send(message, smtpServer);

    //Sending Message
    String uri='https://smsmapi.engineeringtgr.com/send/?Mobile=9010097404&Password=sachin&Message=+message1+&To=+number+&Key=saching3mhgtrjdh';
    http.Response res= await http.get(Uri.encodeFull(uri),
    headers: {
    "Accept":"Application/json"
    }
    );

    print(json.decode(res.body));



    }
                  ),
        )        
                    
                              ],
                              ),
                            );
                     
                          
                        
}



//updating the lists of visitor

List<RegStore> updateListView() {
  final Future<Database> dbfuture =databaseVisitor.initializeDatabase();
  dbfuture.then((database){

    Future<List<RegStore>> regListFuture=databaseVisitor.getNoteList();
    
    regListFuture.then((regVisitList){
      this.regVisitList=regVisitList;
    });
  });

  

}

//updating the lists of host

List<RegHostStore> updateListHostView() {
  final Future<Database> dbfuture =databaseHost.initializeDatabase();
  dbfuture.then((database){

    Future<List<RegHostStore>> regListFuture=databaseHost.getNoteHostList();
    
    regListFuture.then((reHostList){
      this.regHostList=regHostList;
    });
  });

  

}

}
                      