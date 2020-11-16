part of 'data_bloc_bloc.dart';

@immutable
abstract class DataBlocEvent {}

class DataCallEvent extends DataBlocEvent{
  final String uid;
  DataCallEvent(this.uid);
}

class DataClearEvent extends DataBlocEvent{}