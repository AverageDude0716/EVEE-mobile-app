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


  Future<void> signUpWithEmailAndPassword(String email, String password) async 
  {
    try 
    {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User successfully signed up
      User? user = userCredential.user;
      // Handle the signed-up user
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
    bool result = false;

    Map<String, Object> update = 
    {

      'last name' : last_name,
      'first name' : first_name,
      'birthdate' : birth_date,
      'gender' : gender,
      'email' : email,
      'password' : password,

    };

    db.collection("voters").doc().set(update).then((value)
    {

      
    
    }).catchError((error) 
    {

      

    });
    
  }

  void save_admin( String last_name, String first_name, int birth_date,
   String gender, String email, String password)
  {

    FirebaseFirestore db = FirebaseFirestore.instance;
    bool result = false;

    Map<String, Object> update = 
    {

      'last name' : last_name,
      'first name' : first_name,
      'birthdate' : birth_date,
      'gender' : gender,
      'email' : email,
      'password' : password,

    };

    db.collection("admins").doc().set(update).then((value)
    {

      
    
    }).catchError((error) 
    {

      

    });
    
  }

}