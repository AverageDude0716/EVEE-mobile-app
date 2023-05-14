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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return  Scaffold
    (

      body: Container
        (

          color: light_yellow,

           child: GestureDetector
           (

              onTap: () 
              {
                FocusScope.of(context).unfocus();
              },

              child: Container
          (

            height: screenHeight,
            width: screenWidth,
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration
            (

              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0)

            ),

            child: Column
            (

              children: 
              [

                const Text
                (
                  'Login',
                  style: TextStyle
                  (
                    color: Colors.black,
                    fontSize: 48.0,
                    decoration: TextDecoration.none
                  ),
                ),//header

                Container
                (

                  margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),

                  child: const TextField
                  (

                    decoration: InputDecoration
                    (

                      hintText: 'Enter E-mail',
                      border: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: light_gray),
                      ),
                      enabledBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: light_gray),
                      ),

                    ),

                  ),

                ),

              ],

            ),

          ),

           ),//form

        ),

    );

  }

}