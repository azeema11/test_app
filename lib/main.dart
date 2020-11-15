import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Repository/auth.dart';
import 'package:test_app/Screens/home.dart';
import 'package:test_app/Screens/login.dart';
import 'package:test_app/bloc/test_bloc_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginBloc(auth: _auth),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) => LoginBloc(auth: _auth),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (BuildContext context, LoginState state) {
              if (state is LoginBlocInitial) {
                return Login();
              }
              if (state is LoginSuccessState) {
                return HomeScreen(name: state.user);
              }
              else{
                return Login();
              }
            },
          ),
        ),
      ),
    );
  }
}
