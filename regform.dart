
import 'dart:core';

class RegStore   //Class used for getting and setting the details of Visitor
{
  
  
  
  String _name;
  String _phone;
  String _email;
  String _intime;


  RegStore(this._name,this._phone,this._email,this._intime);
  
  get now => _intime;
  
  get name => _name;
  
  get phone => _phone;

  get email => _email;

  

  


  set intime(String intime){
    this._intime=intime.toString();
  }
  
  set name(String name) {
    this._name=name;

  }

  set phone(String phone){
    this._phone=phone;
  }

  set email(String email){
    this.email=email;

  }

  

  

  Map<String,dynamic> toMap() {             //As we cant store the details as list we need to store them as map
    var map=Map<String, dynamic>();
    map['intime']=_intime;
    map['name']=_name;
    map['phone']=_phone;
    map['email']=_email;
    

    return map;
  }
  
  


  RegStore.fromMapObject(Map<String,dynamic> map) {        //Getting the values of database as map objects.
   this._intime=map['intime'];  
    this._name=map['name'];
    this._phone=map['phone'];
    this._email=map['email'];
    
  }
  
}