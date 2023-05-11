import 'package:evee/landing_page.dart';
import 'package:evee/login.dart';
import 'package:flutter/material.dart';

void main() 
{
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
