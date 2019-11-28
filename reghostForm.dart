
import 'dart:core';

class RegHostStore     //Class used for getting and setting the details of Host
{
  String _name;
  String _phone;
  String _email;
  String _address;

  RegHostStore(this._name,this._phone,this._email,this._address);
  
  get name => _name;
  
  get phone => _phone;

  get email => _email;

  get adrress => _address;

  


  set name(String name) {
    this._name=name;

  }

  set phone(String phone){
    this._phone=phone;
  }

  set email(String email){
    this.email=email;

  }

  set address(String address){
    this.address=address;
  }

  

  Map<String,dynamic> toMap() {                       //As we cant store the details as list we need to store them as map
    var map1=Map<String, dynamic>();
    map1['name']=_name;
    map1['phone']=_phone;
    map1['email']=_email;
    map1['address']=_address;
    

    return map1;
  }
  
  


  RegHostStore.fromMapObject(Map<String,dynamic> map1) {                //Getting the values of database as map objects.
    this._name=map1['name'];
    this._phone=map1['phone'];
    this._email=map1['email'];
    this._address=map1['address'];
  }
  
}