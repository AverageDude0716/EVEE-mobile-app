// this is the login screen/page.

import 'package:evee/create_account.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/voter_home_page.dart';
import 'package:evee/firebase_functions.dart';
import 'package:evee/login_loading.dart';
import 'package:evee/admin_home_page.dart';
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

  Firebase_func firebase_func = Firebase_func();

  void _login_button_press()
  {
    String email = email_contoller.text;
    String password = password_controller.text;

    if(email.isNotEmpty && password.isNotEmpty)
    {

      try
    {
      firebase_func.loginWithEmailAndPassword(email, password);
    }
    catch(e)
    {
     
     SnackBar snackBar = SnackBar
              (
                content: Text('Login Up failed. $e' ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
    }
    finally
    {

      Navigator.push
                (
                  context,
                  MaterialPageRoute(builder: (context) => Login_loading())
                );

    }

    }
    else
    {

      const SnackBar snackBar = SnackBar
              (
                content: Text('Fill up all fields.' ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }


  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return  WillPopScope
    (
      child: Scaffold
      (

        body: SingleChildScrollView
        (

          child: Container
                (

                  height: screenHeight,
                  width: screenWidth,

                  decoration: const BoxDecoration
                  (

                    image: DecorationImage
                    (
                      image: AssetImage('assets/background_img/background_1.jpg'),
                      fit: BoxFit.cover,
                    )

                  ),


                  child: GestureDetector
                  (

                      onTap: () 
                      {
                        FocusScope.of(context).unfocus();
                      },

                      child: Container
                      (

                        //form design
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

                              child:  TextField
                              (
                                controller: email_contoller,
                                decoration: const InputDecoration
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
                                      controller: password_controller,
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
                              onPressed: () 
                              {

                              _login_button_press();

                              },
                              child: const Text('Login')
                            ),

                            //to sign up
                            ElevatedButton
                            (
                              onPressed: () 
                              {

                                Navigator.push
                                (
                                  context,
                                  MaterialPageRoute(builder: (context) => Create_account_page())
                                );

                              },
                              child: const Text('Dont have an account? Sign in')
                            )
        
                          ],

                        ),

                      ),

                  ),//form

                ),

        ),

      ), 
      
      
      onWillPop: () async
      {
        return false;
      }
    );

  }

}