// this is the first screen/page shown.

import 'package:evee/login.dart';
import 'styles.dart';
import 'package:flutter/material.dart';


class Landing_page extends StatefulWidget
{

  @override
  State<Landing_page> createState() => _Landing_page_state();

}

class _Landing_page_state extends State<Landing_page>
{

   @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return   WillPopScope
    (
      child: Scaffold
      (

        body: Center
        (
          
          child: Container
          (
            height: screenHeight,
            width: screenWidth,

            decoration: const BoxDecoration
            (

              image: DecorationImage
              (
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              )

              /*gradient: LinearGradient
              (
                colors: 
                [
                  blue2,
                  purple2,
                  yellow2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )*/

            ),

            child: Column
            (

              children:  [

                Container
                (

                  margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),

                  child: const Text
                  (
                    'Welcome to Evee',
                    style: TextStyle
                    (
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),

                ),


                Container
                (
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 90),
                  
                  child:Image.asset
                  (
                    'assets/round_icons2.png',
                    
                    width: 400, // Set the width of the image
                    height: 400, // Set the height of the image
                  ),

                ),


                Container
                (
                  width: 130.0,

                  child: ElevatedButton
                  ( 

                    onPressed: ()
                    {

                      Navigator.push
                      (
                        context,
                        MaterialPageRoute(builder: (context) => Login_page())
                      );

                    },
                    style: const ButtonStyle
                      (
                        backgroundColor: MaterialStatePropertyAll(purple2),
                      ),
                    child: const Text
                    (
                      'Login',
                      style: TextStyle
                      (
                        fontSize: 20,
                      ),
                    )

                  ),

                ),

              ],

            ),

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

