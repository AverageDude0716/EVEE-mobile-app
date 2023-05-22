import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Admin_profile_page extends StatefulWidget
{

    @override
    State<Admin_profile_page> createState() => _Admin_profile_page_state();

}

class _Admin_profile_page_state extends State<Admin_profile_page>
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

          child: Text('Profilo Page', style:  TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),

        ),

      ),


    );

  }

}