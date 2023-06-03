import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evee/admin_dashboard.dart';
import 'package:evee/firebase_functions.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/voter_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Poll_voting_page extends StatefulWidget
{
  final String id;

  Poll_voting_page({required this.id});

    @override
    State<Poll_voting_page> createState() => _Poll_voting_page_state();

}

class _Poll_voting_page_state extends State<Poll_voting_page>
{
  TextEditingController essay_answer_controller = TextEditingController(); // Move inside the class
  Firebase_func firebase_func = Firebase_func();
  FirebaseAuth auth = FirebaseAuth.instance;
  

  String selectedOption = 'Rank Choice';
  List<String> options = ['Multiple Choice', 'Essay', 'Rank Choice' /*, 'Single Choice'*/];

  int rank_selected = 0;

  int multiple_choice_selected = 0;

  bool option1 = false, option2 = false, option3 = false, option4 = false;

  int question_num = 1;

  late Future<List<List<dynamic>>> _fetchDocuments;
  late Future<String> _get_poll_name;


   @override
  void dispose() {
    essay_answer_controller.dispose();
    super.dispose();
  }


  void save(BuildContext context, String id)
  {
    String poll_type = 'placeholder';
    
    User? user = auth.currentUser;
    if(user != null)
    {

      String user_id = user.uid;


      firebase_func.get_question_data(id).then((QuerySnapshot<Map<String, dynamic>>querySnapshot) 
    async {

      if(querySnapshot.docs.isNotEmpty)
      {
        DocumentSnapshot firstDocumentSnapshot = querySnapshot.docs.first;
        Map<String, dynamic>? data = firstDocumentSnapshot.data() as Map<String, dynamic>?;

        if(data != null)
        {

          String qst_id= firstDocumentSnapshot.id;
          poll_type = data['type'];
          String responders = data['responders'];
          
              if(responders == 'none')
              {

                responders = '$user_id/';

              }
              else
              {

                responders = '$responders$user_id/';

              }

          switch(poll_type)
          {

            case 'Multiple Choice':
              int op1_respo = data['option 1 responses'];
              int op2_respo = data['option 2 responses'];
              

              switch(multiple_choice_selected)
              {
                case 0:
                  op1_respo++;
                  break;
                case 1:
                  op2_respo++;
                  break;  
              }

              await FirebaseFirestore.instance.collection('polls')
                .doc(id).collection('questions').doc(qst_id).update(
                  {
                    'option 1 responses': op1_respo,
                    'option 2 responses': op2_respo,
                    'responders': responders,
                  });

              break;

            case 'Essay':
              String answer = essay_answer_controller.text;
              int respondents = data['responses'];
              int respons = respondents + 1;
              String answer_str = 'answer $respons';

               await FirebaseFirestore.instance.collection('polls')
                .doc(id).collection('questions').doc(qst_id).update(
                  {
                    
                    'responders': responders,
                    'responses': respons,
                    answer_str: answer,
                  });

              break;

            case 'Rank Choice':
              int r1 = data['rank 1 responses'];
              int r2 = data['rank 2 responses'];
              int r3 = data['rank 3 responses'];
              int r4 = data['rank 4 responses'];
              
              switch(rank_selected)
              {
                case 0:
                  r1++;
                  break;
                case 1:
                  r2++;
                  break;
                case 2:
                  r3++;
                  break;
                case 3:
                  r4++;
                  break;    
              }

                await FirebaseFirestore.instance.collection('polls')
                .doc(id).collection('questions').doc(qst_id).update(
                  {
                    
                    'responders': responders,
                    'rank 1 responses': r1,
                    'rank 2 responses': r2,
                    'rank 3 responses': r3,
                    'rank 4 responses': r4,
                  });

              break;

            default:
              break;      

          }

        }

      }

    });

    }

  }


  void rank_select(int index) {
    setState(() {
      rank_selected = index;
      switch(index)
      {
        case 0:
          option1 = true;
          option2 = false;
          option3 = false;
          option4 = false;
          break;

        case 1:
          option1 = false;
          option2 = true;
          option3 = false;
          option4 = false;
          break;

        case 2:
          option1 = false;
          option2 = false;
          option3 = true;
          option4 = false;
          break;

        case 3:
          option1 = false;
          option2 = false;
          option3 = false;
          option4 = true;
          break;

      }
    });
  }


  void multiple_choice_select(int index) {
    setState(() {
      multiple_choice_selected = index;
    });
  }

  
  Future<List<List<dynamic>>> fetchDocuments(String id) async 
  {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('polls').doc(id).collection('questions');

    QuerySnapshot snapshot = await collection.get();

    List<List<String>> list = [];
    List<String> questions = [];
    

    for (var doc in snapshot.docs)
    {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      
      String type = data['type'];
      String question = data['question'];
      String responders = data['responders'];

      questions.add(type);
      questions.add(question);
      questions.add(responders);

      if(type == 'Multiple Choice')
      {
        String op1 = data['option 1'];
        String op2 = data['option 2'];

        questions.add(op1);
        questions.add(op2);
      }

      list.add(questions);
    }

    return list;
  }


  Future<String> get_poll_name(String id) async
  {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('polls');

    String poll_name = 'pl'; // Replace with the ID of the document you want to retrieve

    await collection.doc(id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) 
      {
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) 
        {
          poll_name = data['poll name'];
        }
      } else {
        
      }
    }).catchError((error) {
      

    });

    return poll_name;

  }


  void initState() {
    super.initState();
    _fetchDocuments = fetchDocuments(widget.id);
    _get_poll_name = get_poll_name(widget.id);
  }


  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    String poll_id = widget.id;
    

    return Scaffold
    (

      body: GestureDetector
      (

        onTap: () 
        {

          FocusScope.of(context).unfocus();

        },

        child: SingleChildScrollView
        (

            child: Column
            (
              mainAxisSize: MainAxisSize.min,
            
              children: 
              [

                //poll name
                Container
                (

                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(20),
                  width: screenWidth,
                  alignment: Alignment.center,
                  decoration: BoxDecoration
                  (

                    color: light_yellow,
                    borderRadius: BorderRadius.circular(20)

                  ),

                  child: FutureBuilder<String>
                  (
                    
                    future: _get_poll_name,
                    builder: (context, snapshot) 
                    {
                      
                      if (snapshot.connectionState == ConnectionState.waiting) 
                      {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) 
                      {

                        String poll_name = snapshot.data!;

                        return Text(poll_name);

                      } 
                      else 
                      {
                        return const Text('Failed to fetch polls.');
                      }  

                    },

                  )

                ),




                //questions
                Container
                (
                  height: screenHeight * 0.5,

                  child: FutureBuilder<List<List<dynamic>>>
                  (
                    future: _fetchDocuments,
                    builder: (context, snapshot) 
                    {
                      if (snapshot.connectionState == ConnectionState.waiting) 
                      {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) 
                      {
                        List<List<dynamic>> polls = snapshot.data!;

                        

                        return Container
                        (
                          height: screenHeight * 0.5,
                          child: ListView.builder
                          (
                            itemCount: polls.length,
                            itemBuilder: (BuildContext context, int index) 
                            {
                              String type = polls[index][0];
                              String question = polls[index][1];
                              String responders = polls[index][2];
                              String op1 = 'pl', op2 = 'pl';

                              if(type == 'Multiple Choice')
                              {
                                op1 = polls[index][3];
                                op2 = polls[index][4];
                              }

                              return Container
                                (
                                  width: screenWidth,
                                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration
                                  (

                                    color: light_yellow,
                                    borderRadius: BorderRadius.circular(20)

                                  ),

                                  constraints: const BoxConstraints
                                  (

                                    minHeight: 300,

                                  ),

                                  child: Column
                                        (

                                          children: 
                                          [

                                            //multiple choice 
                                            Visibility
                                            (

                                              visible: type == 'Multiple Choice',
                                              child: Column
                                              (

                                                children: 
                                                [

                                                  //question
                                                  Container
                                                  (

                                                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),

                                                    child: SingleChildScrollView
                                                    (
                                                      child: Text(question),
                                                    ),

                                                  ),

                                                  //option1
                                                  Container
                                                  (

                                                    //margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                                    child: ElevatedButton
                                                        (

                                                          onPressed: () => multiple_choice_select(0),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: multiple_choice_selected == 0 ? Colors.green : Colors.blue,
                                                          ),
                                                          child:  Text(op1),

                                                        ),

                                                  ),

                                                  //option 2
                                                  Container
                                                  (

                                                    //margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                                    child: ElevatedButton
                                                        (

                                                          onPressed: () => multiple_choice_select(1),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: multiple_choice_selected == 1 ? Colors.green : Colors.blue,
                                                          ),
                                                          child:  Text(op2),

                                                        ),

                                                  ),

                                                ],

                                              )

                                            ),

                                            //essay
                                            Visibility
                                            (

                                              visible: type == 'Essay',
                                              child: Column
                                              (

                                                children: 
                                                [

                                                  Container
                                                  (

                                                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),

                                                    child: SingleChildScrollView
                                                    (
                                                      child: Text(question),
                                                    ),

                                                  ),

                                                  SingleChildScrollView
                                                  (

                                                    scrollDirection: Axis.vertical,
                                                    child: TextField
                                                    (
                                                      maxLines: null,
                                                      keyboardType: TextInputType.multiline,

                                                      controller: essay_answer_controller,

                                                      decoration: const InputDecoration
                                                      (

                                                        hintText: 'User Input goes here',
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

                                                  ),

                                                ],

                                              )

                                            ),

                                            //rank
                                            Visibility
                                            (

                                              visible: type == 'Rank Choice',
                                              child: Column
                                              (

                                                children: 
                                                [

                                                  Container
                                                  (

                                                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),

                                                    child: SingleChildScrollView
                                                    (
                                                      child: Text(question),
                                                    ),

                                                  ),

                                                  Row
                                                  (

                                                    children: 
                                                    [

                                                      //option1
                                                      Expanded
                                                      (
                                                        flex: 1,
                                                        child: ElevatedButton
                                                        (

                                                          onPressed: () => rank_select(0),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: rank_selected == 0 ? Colors.green : null,
                                                          ),
                                                          child: const Text('1'),

                                                        ),
                                                      ),

                                                      //option2
                                                      Expanded
                                                      (
                                                        flex: 1,
                                                        child: ElevatedButton
                                                        (

                                                          onPressed: () => rank_select(1),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: rank_selected == 1 ? Colors.green : null,
                                                          ),
                                                          child: const Text('2'),

                                                        )
                                                      ),

                                                      //option3
                                                      Expanded
                                                      (
                                                        flex: 1,
                                                        child: ElevatedButton
                                                        (

                                                          onPressed: () => rank_select(2),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: rank_selected == 2 ? Colors.green : null,
                                                          ),
                                                          child: const Text('3'),

                                                        )
                                                      ),

                                                      //option4
                                                      Expanded
                                                      (
                                                        flex: 1,
                                                        child: ElevatedButton
                                                        (

                                                          onPressed: () => rank_select(3),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: rank_selected == 3 ? Colors.green : null,
                                                          ),
                                                          child: const Text('4'),

                                                        )
                                                      ),

                                                    ],

                                                  )

                                                ],

                                              )

                                            ),

                                            //single
                                            /*Visibility
                                            (

                                              visible: type == 'Single Choice',
                                              child: Text('Single')

                                            ),*/

                                          ],

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

                ),




                //save
                Container
                (

                  child: ElevatedButton
                  (
                    onPressed: () 
                    {

                      save(context, poll_id);
                      Navigator.push
                      (
                        context, 
                        MaterialPageRoute(builder: (context) => Voter_dashboard_page())
                      );

                    },
                    child: const Text('Save'),
                  )

                ),

                //cancel
                Container
                (

                  child: ElevatedButton
                  (
                    onPressed: () 
                    {
                      Navigator.push
                      (
                        context, 
                        MaterialPageRoute(builder: (context) => Voter_dashboard_page())
                      );
                    },
                    child: const Text('Cancel'),
                  )


                ),

              ],

            ),

        ),

      ),
      
    );

  }

}