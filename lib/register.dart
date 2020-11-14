import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget{

  _Register createState() => _Register();
}

class _Register extends State<Register>{

  String email;
  String password;
  String name;
  final formkey = GlobalKey<FormState>();
  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();

  @override

  Widget build(BuildContext context){
    final ro = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            textColor: Colors.green[800],
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Already have an Account?",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white12,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.green[800],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.height/100, MediaQuery.of(context).size.width/20, 0.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/50,),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.green[800],
                  backgroundImage: img == null? null:FileImage(img),
                  radius: 60.0,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.photo), 
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) { 
                            return AlertDialog(
                              title: Text("Pick image from"),
                              content: SingleChildScrollView(
                                child: Row(
                                  children:[ 
                                    Container(
                                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/60, MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/60),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.photo_album), 
                                            onPressed: (){
                                              photo(context, ImageSource.gallery);
                                            },
                                          ),
                                          Text("Gallery")
                                        ]
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/60, MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/60),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.camera_alt), 
                                            onPressed: (){
                                              photo(context, ImageSource.camera);
                                            },
                                          ),
                                          Text("Camera")
                                        ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        );
                      }
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60,),
              TextFormField(
                focusNode: f3,
                decoration: InputDecoration(
                  labelText:"Name",
                  labelStyle: TextStyle(
                    color: f3.hasFocus ? Colors.green[800]:null,
                    ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width:2.0,color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.green[800], width: 2.0),),
                ),
                validator: RequiredValidator(errorText: "Enter your name"),
                onChanged: (value) => name = value,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              TextFormField(
                focusNode: f4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Phone Number",
                  labelStyle: TextStyle(
                    color: f4.hasFocus ? Colors.green[800]:null,
                    ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width:2.0,color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.green[800], width: 2.0),),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Enter your phone number"),
                  
                ]),
                onChanged: (value) => pno = int.parse(value),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60,),
              Container(
                child: Text(
                  "Gender",
                  style:TextStyle(
                    fontSize:18.0,
                    color: Colors.grey[600]
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new Radio(value: 1, groupValue: val, onChanged: changevalue),
                  new Text("Male"),
                  new Radio(value: 2, groupValue: val, onChanged: changevalue),
                  new Text("Female"),
                ],
              ),
              TextFormField(
                focusNode: f5,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText:"Date Of Birth [yyyy-mm-dd]",
                  labelStyle: TextStyle(
                    color: f5.hasFocus ? Colors.green[800]:null,
                    ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width:2.0,color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.green[800], width: 2.0),),
                ),
                validator: (value){
                  if(value == ""){
                    return "Enter a valid date";
                  }
                  else if(value != DateFormat("yyyy-MM-dd").format(DateTime.parse(value))) {
                    return "Enter a valid date";
                  }
                  else{}
                  return null;
                },
                onChanged: (value) => date = DateTime.parse(value),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              TextFormField(
                focusNode: f1,
                decoration: InputDecoration(
                  labelText:"Email-Id",
                  labelStyle: TextStyle(
                    color: f1.hasFocus ? Colors.green[800]:null,
                    ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width:2.0,color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.green[800], width: 2.0),),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Enter your email-id"),
                  EmailValidator(errorText: "Enter valid email address"),
                ]),
                onChanged: (value) => email = value,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              TextFormField(
                obscureText: true,
                focusNode: f2,
                decoration: InputDecoration(
                  labelText:"Password",
                  labelStyle: TextStyle(
                    color: f2.hasFocus ? Colors.green[800]:null,
                    ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width:2.0,color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.green[800], width: 2.0),),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Enter the Password"),
                  MinLengthValidator(6, errorText: "Password must have minimum 6 characters"),
                  PatternValidator(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$', errorText: "Password must contain atleast one number and one letter")
                ]), 
                onChanged: (value) => password = value,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              TextFormField(
                obscureText: true,
                focusNode: f6,
                decoration: InputDecoration(
                  labelText:"Confirm Password",
                  labelStyle: TextStyle(
                    color: f6.hasFocus ? Colors.green[800]:null,
                    ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width:2.0,color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.green[800], width: 2.0),),
                ),
                validator: (value){
                  return MatchValidator(errorText: "Passwords do not match").validateMatch(value, password);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              Container(
                child: Container(
                  child: CheckboxListTile(
                    title: const Text("Agree terms and conditions"),
                    value: c == 0,
                    onChanged: (bool value){
                      setState(() {
                        c = value ? 0 : 1;
                      });
                    },
                  ),
                ),
              ),
              Text(
                ro.rstr == null ? "" : ro.rstr,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/80),
              Center(
                child: RaisedButton(
                  color: Colors.green[800],
                  textColor: Colors.white,
                  onPressed: () {
                    ro.rerrorstr(null);
                    if(formkey.currentState.validate() == false){
                    }
                    else if(val == 0){
                      ro.rerrorstr("Please select a gender");
                    }
                    else if(c == 1){
                      ro.rerrorstr("Agree to terms and conditions");
                    }
                    else{
                      ro.register(email, password, name, pno, img, date, val == 1? "Male" : val == 2? "Female":null).whenComplete(() {
                        if(ro.usr != null){
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/40),
            ],
          ),
        ),        
      ),
    );
  }
}