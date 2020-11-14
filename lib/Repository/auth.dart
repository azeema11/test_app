import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  String rstr;
  String lstr;
  User usr;
  FirebaseFirestore store;

  void lerrorstr(error) {
    lstr = error;
  }

  void rerrorstr(error) {
    rstr = error;
  }

  Future login(email, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => usr = value.user);
  }

  Future register(email, password, name) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).whenComplete(() {
      store.collection("Users").doc().set({"name": name, "email": email});
    });
  }
}
