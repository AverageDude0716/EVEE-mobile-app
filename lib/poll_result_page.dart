import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Poll_result_page extends StatefulWidget
{

    @override
    State<Poll_result_page> createState() => _Poll_result_page_state();

}

class _Poll_result_page_state extends State<Poll_result_page>
{
  
  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold
    (

      body: SingleChildScrollView
      (

        child: Container
        (

          color: light_yellow,
          width: screenWidth,

          child: Text('result Page', style:  TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),

        ),

      ),


    );

  }

}

/**
 
 * FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>
    (

      future: firebase_func.get_user_data(uid),
      builder: (context, snapshot) 
      {

        if (snapshot.connectionState == ConnectionState.waiting) 
        {
          // Show a loading indicator while data is being fetched
          return const CircularProgressIndicator();
        } 
        else if (snapshot.hasError) 
        {
          // Handle error case
          return Text('Error: ${snapshot.error}');

        } 
        else if (snapshot.hasData) 
        {
          // Data retrieval is successful
          Map<String, dynamic> data = snapshot.data!.data()!;
          String last_name = data['last name'];
          String first_name = data['first name'];
          int birth_date = data['birthdate'];
          String gender = data['gender'];
          String email = data['email'];
          String password = data['password'];
          String polls = data['polls'];

          List<String> poll_list = polls.split('/').where((poll_list) => poll_list.isNotEmpty).toList();
          List<String> poll_id = [];

        } else {
          // Data is null
          return Text('No data found.');
        }

      },

    );  

 */