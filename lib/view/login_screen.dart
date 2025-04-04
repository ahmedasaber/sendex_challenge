import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
  
}

class _LoginState extends State<Login>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 25),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xffe8ebff),
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Image.asset('assets/images/man.png', height: 70, width: 70),
              ),
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      title: Text('Login',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                      subtitle: Text('Login to continue using the app'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      title: Text('Email',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                      subtitle: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Color(0x80eaeaea),
                          filled: true,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color:Color(0xffeaeaea),width: 2)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color:Color(0xffeaeaea),width: 2)
                          ),
                        ),
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      title: Text('Password',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                      subtitle: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible? Icon(CupertinoIcons.eye_fill) : Icon(CupertinoIcons.eye_slash)
                          ),
                          fillColor: Color(0x80eaeaea),
                          filled: true,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color:Color(0xffeaeaea),width: 2)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color:Color(0xffeaeaea),width: 2)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10),
                    child: TextButton(
                        onPressed: (){},
                        child: Text('Forget Password', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                    ),
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(18)
                ),
                onPressed: (){
                  authService.signWithEmail(context,_emailController.text, _passwordController.text);
                },
                child: Text('Login',style: TextStyle(fontSize:16, color: Colors.white),)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: (){},
                    child: Text('Sign up', style: TextStyle(fontWeight:FontWeight.bold,color: Colors.blue),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}