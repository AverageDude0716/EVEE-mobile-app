// this is the page/screen for creating accounts/sign up

import 'package:evee/create_admin.dart';
import 'package:evee/create_voter.dart';
import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Create_account_page extends StatefulWidget
{

    @override
    State<Create_account_page> createState() => _Create_account_page_state();

}

class _Create_account_page_state extends State<Create_account_page>
{

  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope
    (
      child: Scaffold
      (

        body: Center
        (

          child: Container
          (

            height: screenHeight,
            width: screenWidth,
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 200),

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
              
             
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration
                        (

                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)

                        ),

              child: Column
              (

                children: 
                [
                  Container
                  (
                    margin: const EdgeInsets.fromLTRB(0, 100, 0, 50),

                    child: const Text
                    (
                      'What type of account would you like to make?',
                      style: TextStyle
                      (
                        fontSize: 20
                      ),
                    ),

                  ),


                  ElevatedButton
                  (
                    onPressed: () 
                    {
                      Navigator.push
                                  (
                                    context,
                                    MaterialPageRoute(builder: (context) => Create_voter_page())
                                  );
                    },
                    style: const ButtonStyle
                      (
                        backgroundColor: MaterialStatePropertyAll(purple2),
                      ),
                    child: const Text('Voter')
                  ),


                  ElevatedButton
                  (
                    onPressed: () 
                    {
                      Navigator.push
                                  (
                                    context,
                                    MaterialPageRoute(builder: (context) => Create_admin_page())
                                  );
                    },
                    style: const ButtonStyle
                      (
                        backgroundColor: MaterialStatePropertyAll(purple2),
                      ),
                    child: const Text('Admin'),
                  )

                ],

              ), 

            )     

          ),

        ),

      ),


      onWillPop: () async
      {
        return true;
      }
    );

  }

}