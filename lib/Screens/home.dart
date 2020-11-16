import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/Auth bloc/test_bloc_bloc.dart';
import 'package:test_app/Data%20bloc/data_bloc_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(LogoutButtonClickEvent());
              BlocProvider.of<DataBlocBloc>(context).add(DataClearEvent());
            },
          )
        ],
      ),
      body: BlocConsumer<DataBlocBloc, DataBlocState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(child: state is DataBlocInitial? RaisedButton(
                onPressed: (){
                  BlocProvider.of<DataBlocBloc>(context).add(DataCallEvent(name));
                },
                child: Text("Load Data"),
              )
              : state is DataLoadState? 
              CircularProgressIndicator()
              : state is DataReceivedState?
              Column(
                children: [
                  Text(state.name),
                  Text(state.email),
                  RaisedButton(
                    onPressed: (){
                      BlocProvider.of<DataBlocBloc>(context).add(DataCallEvent(name));
                    },
                    child: Text("Load Data"),
                  )
                ],
              ) 
              : state is DataFailedState? 
              Column(
                children: [
                  Text(state.error),
                  RaisedButton(
                    onPressed: (){
                      BlocProvider.of<DataBlocBloc>(context).add(DataCallEvent(name));
                    },
                    child: Text("Load Data"),
                  )
                ],
              )
              :
              RaisedButton(
                onPressed: (){
                  BlocProvider.of<DataBlocBloc>(context).add(DataCallEvent(name));
                },
                child: Text("Load Data"),
              ),
              )
            ],
          );
        },
      ),
    );
  }
}
