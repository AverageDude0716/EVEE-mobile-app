import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evee/firebase_functions.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/poll_create_page.dart';
import 'package:evee/poll_result_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:clipboard/clipboard.dart';



class Admnin_home_page extends StatefulWidget
{

    @override
    State<Admnin_home_page> createState() => _Admin_home_page_state();

}

class _Admin_home_page_state extends State<Admnin_home_page> {
  Firebase_func firebase_func = Firebase_func();
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<String> get_poll_id(String values) async
  {

    String id = 'pl';
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('polls');

    QuerySnapshot querySnapshot = await usersCollection.where('poll name', isEqualTo: values).get();

    
    if (querySnapshot.docs.isNotEmpty) {
      
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

      // Use the data as needed
      if (data != null) 
      {
       
        id = data['poll id'];

        
       
      }
    } else {
      print('No documents found');
    }
    return id;

  }


  


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    late String uid;
    final user = auth.currentUser;
    if(user != null)
    {
      uid = user.uid;
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>
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

        
            return FutureBuilder<List<String>>(
            future: Future.wait(poll_list.map((poll) => get_poll_id(poll)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while data is being fetched
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle error case
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Data retrieval is successful
                List<String> pollIdList = snapshot.data!;
                poll_id.addAll(pollIdList);

            
                return Scaffold
              (

                body: Column
                      (

                        children: 
                        [

                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                            alignment: Alignment.center,

                            child: const Text
                            (
                              'Polls',
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),

                          ),


                          //listview
                          Expanded
                          (
                            
                            child: Container
                            (

                              child: polls != 'none'
                                ? ListView.builder
                                (

                                  itemBuilder: (context, position)
                                  {

                                    return Container
                                    (

                                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration
                                      (

                                        color: light_yellow,
                                        borderRadius: BorderRadius.circular(10),

                                      ),

                                      child: Column
                                      (

                                        children: 
                                        [

                                          Text
                                          (
                                            poll_list[position],
                                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                          ),

                                          GestureDetector
                                          (
                                            onTap: () {
                                            String textToCopy = poll_id[position];
                                            FlutterClipboard.copy(textToCopy).then((value) 
                                            {
                                              const SnackBar snackBar = SnackBar
                                              (
                                                content: Text('Poll ID copied to clipboard'),
                                                behavior: SnackBarBehavior.floating,
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            });
                                            },
                                            child: const Text(
                                              'Tap to copy Poll ID',
                                              style:  TextStyle(fontSize: 15),
                                            ),
                                          ),


                                          GestureDetector
                                          (

                                            onTap: () 
                                            {
                                              String id = poll_id[position];

                                              Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Poll_result_page(id: id)),
                                              );

                                            },

                                            child: const Text('view poll results'),

                                          ),

                                        ],

                                      )

                                    );

                                  },
                                  itemCount: poll_list.length,

                                )
                                : Container
                                    (
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration
                                      (

                                        color: light_yellow,
                                        borderRadius: BorderRadius.circular(10),

                                      ),

                                      child: const Text
                                      (
                                        'No polls created. Create One Now!',
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                      ),

                                    ),

                            ), 


                          ),

                        ],

                      ),

                      //add buttons
                      floatingActionButton: FloatingActionButton
                            (
                              onPressed: () 
                              {

                                Navigator.push
                                (
                                  context, 
                                  MaterialPageRoute(builder: (context) => Poll_create_page())
                                );

                              },
                              child: const Icon(Icons.add_circle)
                            ),

              );


              } else {
                // Data is null
                return Text('No data found.');
              }
            },
          );


        } else {
          // Data is null
          return Text('No data found.');
        }

      },

    );
  }
}

