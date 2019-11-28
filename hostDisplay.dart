import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(HostDisplay());
}


class HostDisplay extends StatelessWidget
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
          home: HostContent(),
    );
  }
        
}


class HostContent extends StatelessWidget{
  BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(            //used for navigating back to the screen


    onWillPop: ()
    {
      movetoLastScreen();
    },
    child:Scaffold(
      appBar: AppBar(
        title: Text('Meeting'), 
        leading: IconButton(icon: Icon(
          Icons.arrow_back),
          onPressed: ()
          {
            movetoLastScreen();
          }
          ),
          ),
      body: Column(children: <Widget>[
        Text('Thanks For Hosting.'),

      ],),
    )
    );
  }

void movetoLastScreen()
{
  Navigator.pop(context);
  
}

}