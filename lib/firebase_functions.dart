import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Firebase_func
{

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


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

}