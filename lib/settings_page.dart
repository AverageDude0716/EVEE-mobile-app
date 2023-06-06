import 'package:evee/admin_dashboard.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/voter_dashboard.dart';
import 'package:evee/voter_home_page.dart';
import 'package:flutter/material.dart';
import 'package:evee/firebase_functions.dart';
import 'styles.dart';


class Settings_page extends StatefulWidget
{
   final String type;

  Settings_page({required this.type});

    @override
    State<Settings_page> createState() => _Settings_page_state();

}

class _Settings_page_state extends State<Settings_page>
{
  Firebase_func firebase_func = Firebase_func();

  /* @override
  void initState() {
    super.initState();
    String type = widget.type;
    _navigateToNextScreen(type);
  }

  void _navigateToNextScreen(String type) 
  {
    SnackBar snackBar = const SnackBar
                (
                  content: Text('Still in development' ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if(type == 'voter')
    {
      Navigator.push
      (
        context, 
        MaterialPageRoute(builder: (context) => Voter_dashboard_page())
      );
    }
    if(type == 'admin')
    {
      Navigator.push
      (
        context, 
        MaterialPageRoute(builder: (context) => Admnin_dashboard_page())
      );
    }
      
  }
  */

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
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
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