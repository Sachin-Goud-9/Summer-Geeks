import 'dart:convert';

import 'package:summer_geeks/models/regform.dart';
import 'package:summer_geeks/screens/visitor_display.dart';
import 'package:summer_geeks/utils/database_host.dart';
import 'package:summer_geeks/utils/database_visitor.dart';
import 'package:summer_geeks/screens/hostreg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqlite_api.dart';
import 'models/regform.dart';
import 'models/reghostForm.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'package:http/http.dart' as http;    

void main()  => runApp(Home());



class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          accentColor: Colors.indigo,
          textSelectionColor: Colors.orange,
          ),
          title: 'Meet',
          home: VisitForm(),
    );
  
}



class VisitForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _VisitForm();

}


class _VisitForm extends State<VisitForm>
{
  

  DatabaseHost databaseHost=DatabaseHost();
  List<RegHostStore> regHostList;


  var _formKey=GlobalKey<FormState>();  //this key is used for Form Validation
  
  TextEditingController na=TextEditingController();    //These are the Controllers of TextFormFields.
  TextEditingController em=TextEditingController();    //These are the Controllers of TextFormFields.
  TextEditingController ph=TextEditingController();    //These are the Controllers of TextFormFields.
  TextEditingController iti=TextEditingController();   //These are the Controllers of TextFormFields.
  TextEditingController oti=TextEditingController();  //These are the Controllers of TextFormFields.
  
                   //List used for storing attributes of Database of Host
  
  var intime;                   //variable for tracking in time of visitor
  DateTime now;
  
  
  @override
  Widget build(BuildContext context){

    
    if(regHostList==null)
    {
      regHostList=List<RegHostStore>();
      regHostList=updateListHostView();      //updating attributes of database into lists
    }
    var hnames;
    hnames=regHostList;
    TextStyle textStyle=Theme.of(context).textTheme.title;   //Used For TextStyle

    
    
                return Scaffold(                       //Scaffold Widget for App bar
                    resizeToAvoidBottomPadding: false,
            
                      appBar: AppBar(
                        title: Text('SummerGeeks-Register'),
                      ),                             
                      body: Form(
                        key: _formKey,
                        
                        child:Padding(padding: EdgeInsets.all(15.0),
                        child: Column(                   //Widgets are stored in Column
                          children: <Widget>[
                            //getImageAsset(),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                                child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: textStyle,
                                controller: na,
                                validator: (String value) {
                                  Pattern p=r'[0-9]*';
                                  RegExp rg=new RegExp(p);     
                                  if(value.isEmpty)                    //used for validating the input name field
                                  {
                                    return 'Please Enter Name';
                                  }
                                  //else if(rg.hasMatch(value))    
                                    //return 'Enter Valid Name';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  hintText: 'Enter Name',
                                  labelStyle: textStyle,
                                  errorStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                              ),
                            )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0,bottom: 5.0), 
                                child: TextFormField(
                                keyboardType: TextInputType.phone,
                                style: textStyle,
                                controller: ph,
                                validator: (String value){                        //Used for validating phone number
                                  Pattern p=r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp rg=new RegExp(p);
                                  
                                  if(value.isEmpty)
                                  {
                                    return 'Please Enter Phone Number';
                                  }
                                  else if(!rg.hasMatch(value))
                                    return 'Enter valid Phone Number';
                
                                },
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: 'Enter Phone with country code eg.+91',
                                  labelStyle: textStyle,
                                  errorStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                              ),
                              
                            )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0,bottom: 5.0), 
                                child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: textStyle,
                                
                                validator: (String value){                           //Used for validating email address
                                  Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value))
                                  {
                                    return 'Enter Valid Email';
                                  }
                                  if(value.isEmpty)
                                    return 'Please Enter email';
                                  },
                                controller: em,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter email address eg.sac@gmail.com',
                                  labelStyle: textStyle,
                                  errorStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                              ),
                              
                            )
                            ),
                      
                                Padding(padding: EdgeInsets.only(top:5.0,bottom: 5.0),
                                  
                                  child: RaisedButton(
                                  color: Theme.of(context).accentColor,
                                  textColor: Theme.of(context).primaryColorDark,
                                  child: Text('Register as Visitor'),
                                  elevation: 10.0,
                                  onPressed: ()
                                  async {
                                    setState(() {
                                      if(_formKey.currentState.validate())
                                      {
                                        
                                        now=DateTime.now();
                                        intime=new DateFormat("H:m:s").format(now).toString();
                                        sendDetails();          //To send the details
                                        Navigator.push(context, MaterialPageRoute(builder: (context){    //Used for navigation between the screens.
                                        return VisitorDisplay();
                                        }));
                                      }
                                      
                                    });



                                    String message1;
                            message1='''Name: na.text
                                  Phone: ph.text
                                    Check-in Time: intime
                                      Email-id: em.text''';




                                    //sending email
                                    String username = 'sachingoud200@gmail.com';
                                    String password = 's@chin_goud';
                                    final smtpServer = mailgun(username, password);
                                    final message = Message()
                                    ..from = Address(username, 'Sachin Goud')
                                    ..recipients.add('$regHostList[2]')
                                    ..ccRecipients.addAll(['sachingoud200@gmail.com', 'sachingoud200@gmail.com'])
                                    ..bccRecipients.add(Address('sachingoud200@gmail.com'))
                                    ..subject = 'Test Dart Mailer library :: 😀 :: '
                                    ..text = message1
                                    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
                                      
                                      final sendReports= await send(message, smtpServer);
                                                                        

                                    //Sending an sms to the Host
                                    String uri='https://smsmapi.engineeringtgr.com/send/?Mobile=9010097404&Password=sachin&Message=+message1+&To=+number+&Key=saching3mhgtrjdh';
                    http.Response res= await http.get(Uri.encodeFull(uri),
                          headers: {
                        "Accept":"Application/json"
                      }
                        );

                                  },
                                ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:10.0,bottom:5.0),
                
                                  child: RaisedButton(
                                    color: Colors.orange,
                                    child: Text('Register as Host'),
                                    textColor: Theme.of(context).accentColor,
                                    onPressed: ()
                                    {
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return HostReg();
                                      }));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                    ));
                  }
                //function for details to the database  
                void sendDetails()
                {
                  String dena=na.text;
                  String deph=ph.text;
                  String deem=em.text;
                  RegStore rg=RegStore(dena, deph, deem, intime);
                  DatabaseVisitor dv= DatabaseVisitor();
                  dv.insertVisitorDetails(rg);
                
                }
                
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
                
                