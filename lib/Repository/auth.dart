import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{

  String rstr;
  String lstr;
  User usr;
  FirebaseFirestore store;
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;

  Auth({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : auth = firebaseAuth ?? FirebaseAuth.instance,
        googleSignIn = googleSignin ?? GoogleSignIn();

  void lerrorstr(error) {
    lstr = error;
  }

  void rerrorstr(error) {
    rstr = error;
  }

  Future login(email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value) => usr = value.user);
  }

  Future googleLogin() async{
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential).then((value) => usr = value.user);
  }

  Future register(email, password, name) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => usr = value.user).whenComplete(() {
      store.collection("Users").doc(usr.uid).set({"name": name, "email": email});
    });
  }

  Future<void> signOut() async {
    auth ?? auth.signOut();
    googleSignIn ?? googleSignIn.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  Future<Map<String,String>> getUser() async {
    DocumentSnapshot doc = await store.collection("Users").doc(usr.uid).get();
    print(doc);
    return {/*"name": name,*/ "email": auth.currentUser.email};
  }
}
