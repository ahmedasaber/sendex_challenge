import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendex_challenge/view/orders_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier{
  final _auth = FirebaseAuth.instance;
  User? _user;

  AuthService(){
    _loadUser();
    _auth.authStateChanges().listen((User? user){
      _user = user;
      if(user!=null){
        _saveUser(user);
      }else{
        _removeUser();
      }
      notifyListeners();
    });
  }

  User? get user => _user;

  signWithEmail(BuildContext context, String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      _saveUser(_user!);
      notifyListeners();
      Navigator.pushReplacementNamed(context, 'orders');
    } on FirebaseAuth catch(e){
      print(e);
    }
  }

  Future<void> _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', user.email??'');
    await prefs.setString('user_uid', user.uid);
  }

  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    String? id = prefs.getString('user_uid');

    if((email != null || email!.isNotEmpty) && id != null){
      _user = _auth.currentUser;
      notifyListeners();
    }
  }

  Future<void> _removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.remove('user_uid');
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    _removeUser();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, 'login', (r)=> false);
  }

}