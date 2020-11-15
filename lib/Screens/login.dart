import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test_app/bloc/test_bloc_bloc.dart';

class Login extends StatefulWidget {
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final FocusNode f1 = new FocusNode();
  final FocusNode f2 = new FocusNode();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final lo = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: Container(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 20,
                MediaQuery.of(context).size.height / 12,
                MediaQuery.of(context).size.width / 20,
                0.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  TextFormField(
                    focusNode: f1,
                    decoration: InputDecoration(
                      labelText: "Email-Id",
                      labelStyle: TextStyle(
                        color: f1.hasFocus ? Colors.green[800] : null,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green[800], width: 2.0),
                      ),
                    ),
                    validator: RequiredValidator(errorText: "Enter the title"),
                    onChanged: (value) => email = value,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
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
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green[800], width: 2.0),
                      ),
                    ),
                    validator:
                        RequiredValidator(errorText: "Enter the Password"),
                    onChanged: (value) => password = value,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  lo.state is LoginFailedState? Text("Enter valid username and password") : Text(""),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Center(
                    child: RaisedButton(
                      color: Colors.green[800],
                      textColor: Colors.white,
                      onPressed: () {
                        //if(formkey.currentState.validate())
                          lo.add(LoginButtonClickEvent(email,password));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  /*Center(
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        //if(formkey.currentState.validate())
                          lo.add(GoogleLoginClickEvent());
                      },
                      child: Text(
                        "Login with google",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
                  Center(
                    child: FlatButton(
                      textColor: Colors.green[800],
                      onPressed: () {
                        Navigator.pushNamed(context, "/r");
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
    );
  }
}
