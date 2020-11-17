import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/Model/user.dart';

class Auth{

  String rstr;
  String lstr;
  User usr;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  DocumentSnapshot doc;
  UserModel user;

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
    await auth.signInWithEmailAndPassword(email: email, password: password)
    .then((value) => usr = value.user);
  }

  Future googleLogin() async{
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential).then((value) => usr = value.user).whenComplete(() async{
      await FirebaseFirestore.instance.collection("Users").doc(usr.uid).set({"Name": usr.displayName, "Email": usr.email});
    });
  }

  Future register(email, password, name) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => usr = value.user).whenComplete(() async{
      await FirebaseFirestore.instance.collection("Users").doc(usr.uid).set({"Name": name, "Email": email});
    });
  }

  Future<void> signOut() async {
    auth ?? auth.signOut();
    googleSignIn ?? googleSignIn.signOut();
    user = null;
    usr = null;
  }

  Future<bool> isSignedIn() async {
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  Future getUser(String uid) async {
    doc = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    print(doc.data());
    user = UserModel(
      name: doc.data()["Name"],
      email: doc.data()["Email"]
    );
  }
}
