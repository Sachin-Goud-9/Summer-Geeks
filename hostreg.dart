import 'package:summer_geeks/models/regform.dart';
import 'package:summer_geeks/models/reghostForm.dart';
import 'package:summer_geeks/screens/hostDisplay.dart';
import 'package:summer_geeks/utils/database_host.dart';
import 'package:summer_geeks/utils/database_visitor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main()=> runApp(HostReg());



class HostReg extends StatelessWidget
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
  
  DatabaseVisitor databaseHelper=DatabaseVisitor();     //Used for Retreiving the values of visitors
  List<RegStore> regList;

  var _formKey=GlobalKey<FormState>();            //this key is used for Form Validation

  bool _autovalidate=false;         
  
  TextEditingController na=TextEditingController();       //These are the Controllers of TextFormFields.
  TextEditingController em=TextEditingController();       //These are the Controllers of TextFormFields.
  TextEditingController ph=TextEditingController();       //These are the Controllers of TextFormFields.
  TextEditingController add=TextEditingController();      //These are the Controllers of TextFormFields.
  
  @override
  Widget build(BuildContext context){



    if(regList==null)
    {
      regList=List<RegStore>();
    }

    TextStyle textStyle=Theme.of(context).textTheme.title;


    return Scaffold(
        resizeToAvoidBottomPadding: false,

          appBar: AppBar(
            title: Text('SummerGeeks-Register'),
          ),                             
          body: Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child:Padding(padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                //getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    controller: na,
                    validator: (String value) {           //used for validation
                      Pattern p=r'[0-9]*';
                      RegExp rg=new RegExp(p);
                      if(value.isEmpty)
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
                    validator: (String value){                      //used for phone numbe validation
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
                    
                    validator: (String value){                   //used for email address validation
                      Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value))
                      {
                        return 'Enter Valid Email';
                      }
                      if(value.isEmpty)
                        return 'Please Enter email';
                      else 
                        return null;
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
              
                Padding(
                  padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    controller: add,
                    validator: (String value) {
                      
                      if(value.isEmpty)
                      {
                        return 'Please Enter Address';
                      }
                      
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter Address',
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
                  child: Text('Register as Host',),
                  elevation: 10.0,
                  onPressed: ()
                  {
                    setState(() {
                      if(_formKey.currentState.validate())
                      {
                        
                        sendDetails();        //Sending the details to the database
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return HostDisplay();
                                        }));
                      }
                      
                    });
                  },
                ),
                ),
                
              ],
            ),
          ),
    ));
  }



String sendDetails()
{
  String dena=na.text;
  String deph=ph.text;
  String deem=em.text;
  String deadd=add.text;
  DatabaseHost dh= DatabaseHost();  //instance of database
  dh.insertHostDetails(RegHostStore(dena, deph, deem,deadd));  //linking with host database
}


}