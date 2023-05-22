import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Settings_page extends StatefulWidget
{

    @override
    State<Settings_page> createState() => _Settings_page_state();

}

class _Settings_page_state extends State<Settings_page>
{
  
  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold
    (

      body: SingleChildScrollView
      (

        child: Container
        (

          color: light_yellow,
          width: screenWidth,

          child: Text('Settings Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  


        ),

      ),


    );

  }

}