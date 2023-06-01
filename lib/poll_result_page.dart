import 'package:evee/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Poll_result_page extends StatefulWidget
{
  final String id;

  Poll_result_page({required this.id});


    @override
    State<Poll_result_page> createState() => _Poll_result_page_state();

}

class _Poll_result_page_state extends State<Poll_result_page>
{
  FirebaseAuth auth = FirebaseAuth.instance;


  late Future<List<String>> poll_info;
  late  Future<List<List<dynamic>>>  question_info;


  Future<List<String>>  get_poll(String id) async
  {

    DocumentReference docref = FirebaseFirestore.instance.collection('polls').doc(id);

    List<String> info = [];

    await docref.get().then((DocumentSnapshot documentSnapshot) 
    {

      if(documentSnapshot.exists)
      {

        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if(data != null)
        {

          String name = data['poll name'];
          String id = data['poll id'];
          String owner =  data['poll owner'];

          info.add(name);
          info.add(id);
          info.add(owner);

        }

      }

    }).catchError((error)
    {

    });

    return info;

  }

  
  Future<List<List<dynamic>>> get_question(String id) async
  {


    CollectionReference collref = FirebaseFirestore.instance.collection('polls').doc(id).collection('questions');

    List<List<dynamic>> questions = [];
    List<dynamic> info = [];

    QuerySnapshot snapshot = await collref.get();

    for(var doc in snapshot.docs)
    {

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      String type = data['type'];
      String question = data['question'];
      String responders = data['responders'];

      info.add(type);
      info.add(question);
      info.add(responders);

      switch(type)
      {

        case 'Multiple Choice':
          String op1 = data['option 1'];
          dynamic op1_res= data['option 1 responses'];

          String op2 = data['option 2'];
          dynamic op2_res = data['option 2 responses'];

          info.add(op1);
          info.add(op1_res);
          info.add(op2);
          info.add(op2_res);
          break;

        case 'Essay':
          dynamic responses = data['responses'];
          String answer = 'answer $responses';

          info.add(responses);

          for(int x = 0; x < responses; x++)
          {

            String ans = data[answer];

            info.add(ans);
          }
          break;  

        case 'Rank Choice':
          dynamic rank1 = data['rank 1 responses'];
          dynamic rank2 = data['rank 2 responses'];
          dynamic rank3 = data['rank 3 responses'];
          dynamic rank4 = data['rank 4 responses'];

          info.add(rank1);
          info.add(rank2);
          info.add(rank3);
          info.add(rank4);
          break;    

      }

      questions.add(info);

    }

    return questions;


  }


  @override
  void initState() {
    super.initState();

    poll_info = get_poll(widget.id);

  }


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