import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendex_challenge/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sendex_challenge/view/orders_screen.dart';
import 'package:sendex_challenge/viewmodel/orders_viremodel.dart';

import '../services/auth_service.dart';
import 'order_details_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter services are initialized
  await Firebase.initializeApp(); // Initializes Firebase
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => OrdersViewModel()..fetchOrder())
    ],
    child:const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return MaterialApp(
      routes: {
        'login': (context)=> Login(),
        'orders': (context)=> Orders(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: authService.user == null ? Login() : Orders(),
    );
  }
}

