import 'package:evee/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_functions.dart';
import 'styles.dart';


class Admin_profile_page extends StatefulWidget
{

    @override
    State<Admin_profile_page> createState() => _Admin_profile_page_state();

}

class _Admin_profile_page_state extends State<Admin_profile_page>
{
  Firebase_func firebase_func = Firebase_func();
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    late String uid;
    final user = auth.currentUser;
    if(user != null)
    {
      uid = user.uid;
    }
    

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
              child: const Text('test'),
            )

          ],

        ),

      ),


    );

  }

}