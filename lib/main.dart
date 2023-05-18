// this is the main dart file. we don't really need to edit this

import 'package:evee/landing_page.dart';
import 'package:evee/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() 
async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget 
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) 
  {

    return MaterialApp
    (

      initialRoute: '/landing_page',
      routes: 
      {
        '/landing_page': (context) => Landing_page(),
        '/login_page': (context) => Login_page(),

      },

    );

  }
}
