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
  TextEditingController email_contoller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  void _login_button_press()
  {
    
  }


  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return  Scaffold
    (

      body: SingleChildScrollView
      (

        child: Container
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

                      //header
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

                      //email textfield
                      Container
                      (

                        margin: const EdgeInsets.fromLTRB(0, 100.0, 0, 0),

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

                      //password textfield
                      Container
                      (

                        margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 100),

                        child: TextField
                              (

                                obscureText: true,
                                decoration: InputDecoration
                                (
                                  hintText: 'Enter Password',

                                  border: const OutlineInputBorder
                                  (
                                    borderSide: BorderSide(color: light_gray),
                                    
                                  ),

                                  enabledBorder: const OutlineInputBorder
                                  (
                                    borderSide: BorderSide(color: light_gray)
                                  ),

                                  suffixIcon: IconButton
                                  (
                                    onPressed: () {},
                                    icon: const Icon(Icons.visibility)
                                  )
                                ),
                                

                              ),

                      ),

                      // login button
                      ElevatedButton
                      (
                        onPressed: () {},
                        child: const Text('Login')
                      ),
                    ],

                  ),

                ),

                ),//form

              ),

      ),

    );

  }

}