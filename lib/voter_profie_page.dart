import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evee/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_functions.dart';
import 'styles.dart';


class Voter_profile_page extends StatefulWidget
{

    @override
    State<Voter_profile_page> createState() => _Voter_profile_page_state();

}

class _Voter_profile_page_state extends State<Voter_profile_page>
{
  Firebase_func firebase_func = Firebase_func();
  final FirebaseAuth auth = FirebaseAuth.instance;

  late Future<List<String>> _user;


  Future<List<String>> get_user(String id) async
  {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference collection = firestore.collection('polls').doc(id);

    List<String> user = [];

    await collection.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) 
      {
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) 
        {
          
          String last_name = data['last name'];
          String first_name = data['first name'];
          String birth_date = data['birthdate'] as String;
          String gender = data['gender'];
          String email = data['email'];
          String password = data['password'];
          String polls = data['polls'];

          user.add(last_name);
          user.add(first_name);
          user.add(birth_date);
          user.add(gender);
          user.add(email);
          user.add(password);
          user.add(polls);

        }
      } else {
        
      }
    }).catchError((error) {
      

    });

    return user;

  }



  @override
  void initState() {
    super.initState();
    
    late String uid;
    final user = auth.currentUser;
    if(user != null)
    {
      uid = user.uid;
    }

    _user = get_user(uid);

  }

  
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

        child: Container
        (

          color: light_yellow,
          width: screenWidth,

          child: Text('Profilo Page', style:  TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),

        ),

      ),


    );

  }

}