import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';



class Firebase_func
{

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  String generateUniqueId() 
  {
  var uuid = Uuid();
  return uuid.v4();
  }



  Future<void> signUpWithEmailAndPassword(String last_name, String first_name, int birth_date,
   String gender,String type, String email, String password) async 
  {
    try 
    {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User successfully signed up
      
      await auth.signInWithEmailAndPassword
      (
        email: email,
        password: password
      );

      if(type == 'voter')
      {
        save_voter(last_name, first_name, birth_date, gender, email, password);
      }
      else if(type == 'admin')
      {
        save_admin(last_name, first_name, birth_date, gender, email, password);
      }

    } 
    catch (e) 
    {
      // Handle sign-up error
    }
  }


  void save_voter( String last_name, String first_name, int birth_date,
   String gender, String email, String password)
  {

    FirebaseFirestore db = FirebaseFirestore.instance;
    final user = auth.currentUser;
    if(user != null)
    {

      String uid = user.uid;

      Map<String, Object> update = 
    {

      'last name' : last_name,
      'first name' : first_name,
      'birthdate' : birth_date,
      'gender' : gender,
      'email' : email,
      'password' : password,
      'account type': 'voter',

    };

    db.collection("voters").doc(uid).set(update).then((value)
    {

      
    
    }).catchError((error) 
    {

      

    });

    db.collection('users').doc(uid).set(update).then((value) 
    {



    }).catchError((error) 
    {


      
    });

    }

  }


  void save_admin( String last_name, String first_name, int birth_date,
   String gender, String email, String password)
  {

    FirebaseFirestore db = FirebaseFirestore.instance;
    final user = auth.currentUser;
    if(user != null)
    {

      String uid = user.uid;

      Map<String, Object> update = 
    {

      'last name' : last_name,
      'first name' : first_name,
      'birthdate' : birth_date,
      'gender' : gender,
      'email' : email,
      'password' : password,
      'account type': 'admin',
      'polls': 'none',

    };

    db.collection("admin").doc(uid).set(update).then((value)
    {

      
    
    }).catchError((error) 
    {

      

    });

    db.collection('users').doc(uid).set(update).then((value) 
    {



    }).catchError((error) 
    {


      
    });

    }
    
  }


  Future<void> loginWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // User successfully logged in
    User? user = userCredential.user;
    // Handle the logged-in user
  } catch (e) {
    // Handle login error
  }
}


  Future<void> logout() async {
  await auth.signOut();
}


  Future<DocumentSnapshot<Map<String, dynamic>>> get_user_data(String uid) async 
  {
    FirebaseFirestore db = FirebaseFirestore.instance;
    
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection('users').doc(uid).get();
    return documentSnapshot;
  }


  void save_question(String poll_id ,String type, String question, String op1, String op2)
  {

    FirebaseFirestore db = FirebaseFirestore.instance;
    final user = auth.currentUser;
    if(user != null)
    {

      late Map<String, Object> updates;

      switch(type)
      {

        case 'Multiple Choice':
          updates =
          {
            'type': type,
            'question': question,
            'option 1': op1,
            'option 1 responses': 0,
            'option 2': op2,
            'option 2 responses': 0,
            'responders': 'none',
          };
          break;

        case 'Essay':
          updates =
            {
              'type': type,
              'question': question,
              'responses': 0,
              'responders': 'none',
            };
          break;

        case 'Rank Choice':
          updates =
          {
            'type': type,
            'question': question,
            'rank 1 responses': 0,
            'rank 2 responses': 0,
            'rank 3 responses': 0,
            'rank 4 responses': 0,
            'responders': 'none',
          };
          break;    
      
      }

      db.collection('polls').doc(poll_id).collection('questions').doc()
      .set(updates).then((value) 
      {

      }).catchError((error)
      {

      });

    }

  }


  Future<void> save_poll(String poll_name, List<List<String>> questions) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final user = auth.currentUser;

  if (user != null) {
    String uid = user.uid;
    String poll_id = generateUniqueId();
    String polls = 'none'; // Initialize with a default value

    Map<String, Object> update = {
      'poll name': poll_name,
      'poll owner': uid,
      'poll id': poll_id,
    };

    await db.collection('polls').doc(poll_id).set(update);

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await get_user_data(uid);

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data()!;
      polls = data['polls'];
    }

    if (polls == 'none') {
      polls = '$poll_name/';
    } else {
      polls = '$polls$poll_name/';
    }

    await db.collection('users').doc(uid).update({'polls': polls});
    await db.collection('admin').doc(uid).update({'polls': polls});

    for (int x = 0; x < questions.length; x++) {
      save_question(
          poll_id, questions[x][0], questions[x][1], questions[x][2], questions[x][3]);
    }
  } else {
    print('fail');
  }
}



}