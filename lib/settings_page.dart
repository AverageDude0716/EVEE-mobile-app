import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:evee/firebase_functions.dart';
import 'styles.dart';


class Settings_page extends StatefulWidget
{

    @override
    State<Settings_page> createState() => _Settings_page_state();

}

class _Settings_page_state extends State<Settings_page>
{
  Firebase_func firebase_func = Firebase_func();

  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold
    (

      body: SingleChildScrollView
      (

        child: Column
        (

          children: 
          [

            Container
            (
              width: screenWidth,
              padding: const EdgeInsets.all(10),

              child: GestureDetector
              (

                onTap: () 
                {

                  try
                  {
                    firebase_func.logout();
                  }
                  catch(e)
                  {
                    SnackBar snackBar = SnackBar
                    (
                      content: Text('Sign out failed. $e' ),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  finally
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context) => Landing_page())
                    );
                  }

                },

                child: const Text('Sign out', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              ),

            ),

          ],

        ),

      ),


    );

  }

}