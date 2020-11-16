import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test_app/Auth bloc/test_bloc_bloc.dart';

class Register extends StatefulWidget {
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  String email;
  String password;
  String name;
  final formkey = GlobalKey<FormState>();
  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f6 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final ro = BlocProvider.of<LoginBloc>(context);
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
      body: BlocConsumer<LoginBloc,LoginState>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, LoginState state){
          return Container(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 20,
                MediaQuery.of(context).size.height / 100,
                MediaQuery.of(context).size.width / 20,
                0.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  TextFormField(
                    focusNode: f3,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        color: f3.hasFocus ? Colors.green[800] : null,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green[800], width: 2.0),
                      ),
                    ),
                    validator: RequiredValidator(errorText: "Enter your name"),
                    onChanged: (value) => name = value,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  TextFormField(
                    focusNode: f1,
                    decoration: InputDecoration(
                      labelText: "Email-Id",
                      labelStyle: TextStyle(
                        color: f1.hasFocus ? Colors.green[800] : null,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green[800], width: 2.0),
                      ),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Enter your email-id"),
                      EmailValidator(errorText: "Enter valid email address"),
                    ]),
                    onChanged: (value) => email = value,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  TextFormField(
                    obscureText: true,
                    focusNode: f2,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: f2.hasFocus ? Colors.green[800] : null,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green[800], width: 2.0),
                      ),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Enter the Password"),
                      MinLengthValidator(6,
                          errorText: "Password must have minimum 6 characters"),
                      PatternValidator(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$',
                          errorText:
                              "Password must contain atleast one number and one letter")
                    ]),
                    onChanged: (value) => password = value,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  TextFormField(
                    obscureText: true,
                    focusNode: f6,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                        color: f6.hasFocus ? Colors.green[800] : null,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green[800], width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      return MatchValidator(errorText: "Passwords do not match")
                          .validateMatch(value, password);
                    },
                  ),
                  /*Text(
                    ro.rstr == null ? "" : ro.rstr,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),*/
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Center(
                    child: RaisedButton(
                      color: Colors.green[800],
                      textColor: Colors.white,
                      onPressed: () {
                        if (formkey.currentState.validate() == false) {
                        } else {
                          ro.add(RegisterButtonClickEvent(email, password, name));
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
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}
