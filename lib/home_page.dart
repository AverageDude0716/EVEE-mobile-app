// this is the first screen/page shown.

import 'package:evee/login.dart';
import 'styles.dart';
import 'package:flutter/material.dart';


class Home_page extends StatefulWidget
{

  @override
  State<Home_page> createState() => _Home_page_state();

}

class _Home_page_state extends State<Home_page>
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

                children:  [

                  
                  Container
                  (
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    
                    child:Image.asset
                    (
                      'assets/stock_image.jpg',
                      
                      width: 350, // Set the width of the image
                      height: 350, // Set the height of the image
                    ),

                  ),


                  Container
                  (

                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 90),

                    child: const Text
                    (
                      'Welcome to Evee',
                      style: TextStyle
                      (
                        
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.center,
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

                  /*Container
                  (
                    child: const Text(''),
                  ),*/

                ],

              ),

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

