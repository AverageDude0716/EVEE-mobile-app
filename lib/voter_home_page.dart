import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evee/firebase_functions.dart';
import 'package:evee/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evee/poll_voting_page.dart';
import 'styles.dart';


class Voter_home_page extends StatefulWidget
{

    @override
    State<Voter_home_page> createState() => _Voter_home_page_state();

}

class _Voter_home_page_state extends State<Voter_home_page> 
{
  TextEditingController poll_id_input_controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<String>> fetchDocuments() async 
  {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('polls');

    QuerySnapshot snapshot = await collection.get();

    List<String> polls = [];

    for (var doc in snapshot.docs)
    {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String poll_name = data['poll name'];
      polls.add(poll_name);
    }

    return polls;
  }



  Future<void> fetchDocumentById(BuildContext context, String documentId) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('polls')
        .doc(documentId)
        .get();

    if (snapshot.exists) {
      QuerySnapshot subCollectionSnapshot =
          await FirebaseFirestore.instance
              .collection('polls')
              .doc(documentId)
              .collection('questions')
              .limit(1)
              .get();

      if (subCollectionSnapshot.docs.isNotEmpty) {
        DocumentSnapshot firstDocument = subCollectionSnapshot.docs.first;

        User? user = auth.currentUser;
        String uid = 'pl';

        if (user != null) {
          uid = user.uid;

          Map<String, dynamic>? data =
              firstDocument.data() as Map<String, dynamic>;

          String respondents = data['responders'];

          List<String> respondentsList = respondents
              .split('/')
              .where((respondentsList) => respondentsList.isNotEmpty)
              .toList();

          if (respondentsList.contains(uid)) {
            SnackBar snackBar = const SnackBar(
              content: Text('You already voted on this poll.'),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Poll_voting_page(id: documentId)),
            );
          }
        }
      } else {
        SnackBar snackBar = const SnackBar(
              content: Text('poll no'),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text('Poll not found.'),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (e) {
     SnackBar snackBar =  SnackBar(
              content: Text('error $e'),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
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
        child: GestureDetector
        (
          onTap: () 
          {
            FocusScope.of(context).unfocus();
          },

          child: Column
          (
            children: 
            [
              Container
              (
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration
                (
                  color: light_yellow,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column
                (
                  children: 
                  [
                    TextField
                    (
                      controller: poll_id_input_controller,
                      decoration: const InputDecoration
                      (
                        hintText: 'Enter Poll ID',
                        border: OutlineInputBorder
                        (
                          borderSide: BorderSide(color: light_gray),
                        ),
                        enabledBorder: OutlineInputBorder
                        (
                          borderSide: BorderSide(color: light_gray),
                        ),
                      ),
                    ),
                    ElevatedButton
                    (
                      onPressed: () async
                      {

                        String poll_id_input = poll_id_input_controller.text;

                        await fetchDocumentById(context,poll_id_input);
                        

                      },
                      child: const Text('Vote'),
                    ),
                  ],
                ),
              ),
              Container
              (
                child: const Text
                (
                  'Polls',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder<List<String>>
              (
                future: fetchDocuments(),
                builder: (context, snapshot) 
                {
                  if (snapshot.connectionState == ConnectionState.waiting) 
                  {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) 
                  {
                    List<String> polls = snapshot.data!;
                    return Container
                    (
                      height: screenHeight * 0.5,
                      child: ListView.builder
                      (
                        itemCount: polls.length,
                        itemBuilder: (BuildContext context, int index) 
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
                            child: Text
                            (
                              polls[index],
                              style: const TextStyle
                              (
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } 
                  else 
                  {
                    return const Text('Failed to fetch polls.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

