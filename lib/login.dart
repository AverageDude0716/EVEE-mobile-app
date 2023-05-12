// this is the login screen/page.

import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Login_page extends StatefulWidget
{

    @override
    State<Login_page> createState() => _Login_page_state();

}

class _Login_page_state extends State<Login_page>
{

  @override
  Widget build(BuildContext context)
  {

    return  const Scaffold
    (

      body: Center
      (

        child: Text
        (
          'login',
          style: TextStyle
          (
            fontSize: 48.0,
          ),
        ),

      ),
     
    );

  }

}