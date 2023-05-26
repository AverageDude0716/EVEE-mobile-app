import 'package:evee/admin_dashboard.dart';
import 'package:evee/firebase_functions.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/voter_dashboard.dart';
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
  Firebase_func firebase_func = Firebase_func();

  String selectedOption = 'Rank Choice';
  List<String> options = ['Multiple Choice', 'Essay', 'Rank Choice' /*, 'Single Choice'*/];

  int rank_selected = 0;

  int multiple_choice_selected = 6;

  bool option1 = false, option2 = false, option3 = false, option4 = false;

  int question_num = 1;


  TextEditingController essay_answer_controller = TextEditingController();


  void save(BuildContext context)
  {
    
    

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

                child: Text('data')

              ),

              //questions
              Container
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

                            visible: selectedOption == 'Multiple Choice',
                            child: Column
                            (

                              children: 
                              [

                                //question
                                Container
                                (

                                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),

                                  child: Text('data')

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
                                        child: const Text('data'),

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
                                        child: const Text('data'),

                                      ),

                                ),

                              ],

                            )

                          ),

                          //essay
                          Visibility
                          (

                            visible: selectedOption == 'Essay',
                            child: Column
                            (

                              children: 
                              [

                                Text('data'),

                                TextField
                                (
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

                              ],

                            )

                          ),

                          //rank
                          Visibility
                          (

                            visible: selectedOption == 'Rank Choice',
                            child: Column
                            (

                              children: 
                              [

                                Text('data'),

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

                            visible: selectedOption == 'Single Choice',
                            child: Text('Single')

                          ),*/

                        ],

                      ),

              ),

              //save
              Container
              (

                child: ElevatedButton
                (
                  onPressed: () 
                  {

                    save(context);
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context) => Admnin_dashboard_page())
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