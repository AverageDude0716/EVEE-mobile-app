import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Admnin_home_page extends StatefulWidget
{

    @override
    State<Admnin_home_page> createState() => _Admin_home_page_state();

}

class _Admin_home_page_state extends State<Admnin_home_page>
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

        ),

      ),


    );

  }

}