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

    return   Scaffold
    (

      backgroundColor: light_yellow,

      body: Center
      (

        child: Column
        (

          children:  [

            Container
            (
              margin: EdgeInsets.fromLTRB(0, 200, 0, 75.0),

                child: const Text
                (

                  'Evee',
                  style: TextStyle
                  (
                    fontSize: 48.0,
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
                  MaterialPageRoute(builder: (context) => Login_page())
                );

              },
              child: const Text
              (
                'Login'
              )

            )

          ],

        ),

      ),
     
    );

  }


}