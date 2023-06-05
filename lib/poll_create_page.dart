import 'package:evee/admin_dashboard.dart';
import 'package:evee/firebase_functions.dart';
import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Poll_create_page extends StatefulWidget
{

    @override
    State<Poll_create_page> createState() => _Poll_create_page_state();

}

class _Poll_create_page_state extends State<Poll_create_page>
{
  Firebase_func firebase_func = Firebase_func();

  String selectedOption = 'Single Choice';
  List<String> options = ['Single Choice', 'Essay', 'Rank Choice' ,  'Multiple Choice'];

  int rank_selected = 0;

  bool option1 = false, option2 = false, option3 = false, option4 = false;

  int question_num = 1;

  TextEditingController poll_name_controller  = TextEditingController();

  TextEditingController single_choice_question_controller = TextEditingController();
  TextEditingController option1_controller = TextEditingController();
  TextEditingController option2_controller = TextEditingController();

  TextEditingController essay_question_controller = TextEditingController();

  TextEditingController rank_question_controller = TextEditingController();

  TextEditingController multiple_choice_controller = TextEditingController();
  TextEditingController op1_controller = TextEditingController();
  TextEditingController op2_controller = TextEditingController();
  TextEditingController op3_controller = TextEditingController();
  TextEditingController op4_controller = TextEditingController();
  TextEditingController op5_controller = TextEditingController();
  bool op3b = false, op4b = false, op5b = false; 


  void save(BuildContext context)
  {
    String poll_name = poll_name_controller.text;
    List<List<String>> questions = [];

    if(poll_name.isNotEmpty)
    {

      for(int x = 0; x < question_num; x++)
      {

        String type = selectedOption;

        late String question, op1, op2, op3, op4, op5;

        switch(type)
        {

          case 'Single Choice':
            question = single_choice_question_controller.text;
            op1 = option1_controller.text;
            op2 = option2_controller.text;
            op3 ='0';
            op4 ='0';
            op5 ='0';

            if(question.isEmpty || op1.isEmpty || op2.isEmpty)
            {
              SnackBar snackBar = const SnackBar
                (
                  content: Text('fill up all fields' ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            break;

          case 'Essay':
            question = essay_question_controller.text;
            op1 = '0';
            op2 = '0';
            op3 ='0';
            op4 ='0';
            op5 ='0';

            if(question.isEmpty)
            {
              SnackBar snackBar = const SnackBar
                (
                  content: Text('fill up all fields' ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            break;

          case 'Rank Choice':
            question = rank_question_controller.text;
            op1 = '0';
            op2 = '0';
            op3 ='0';
            op4 ='0';
            op5 ='0';
            if(question.isEmpty)
            {
              SnackBar snackBar = const SnackBar
                (
                  content: Text('fill up all fields' ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            break;    

          case 'Multiple Choice':
            question = multiple_choice_controller.text;
            op1 = op1_controller.text;
            op2 = op2_controller.text;
            op3 = op3_controller.text;
            op4 = op4_controller.text;
            op5 = op5_controller.text;

            if(op3b == true && op4b == false && op5b == false)
            {
              if(question.isEmpty || op1.isEmpty || op2.isEmpty || op3.isEmpty)
              {
                SnackBar snackBar = const SnackBar
                  (
                    content: Text('fill up all fields' ),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
            else if(op4b == true  && op5b == false)
            {
              if(question.isEmpty || op1.isEmpty || op2.isEmpty || op3.isEmpty || op4.isEmpty )
            {
              SnackBar snackBar = const SnackBar
                (
                  content: Text('fill up all fields' ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            }
            else if (op5b == true)
            {
              if(question.isEmpty || op1.isEmpty || op2.isEmpty || op3.isEmpty || op4.isEmpty || op5.isEmpty)
            {
              SnackBar snackBar = const SnackBar
                (
                  content: Text('fill up all fields' ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            }
            break;

        }
        List<String> qst = [type, question, op1, op2, op3, op4, op5];

        questions.add(qst);
      
      }

    
      firebase_func.save_poll(poll_name, questions);

      Navigator.push
      (
        context, 
        MaterialPageRoute(builder: (context) => Admnin_dashboard_page())
      );

    }
    else
    {
      SnackBar snackBar = const SnackBar
              (
                content: Text('fill up all fields' ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }


  void rank_select(int index) {
    setState(() {
      rank_selected = index;
    });
  }

  
  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    

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
                decoration: BoxDecoration
                (

                  color: light_yellow,
                  borderRadius: BorderRadius.circular(20)

                ),

                child: TextField
                (
                  controller: poll_name_controller,

                  decoration: const InputDecoration
                  (

                    hintText: 'Enter Poll Name',
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

                    //dropdown menu
                    DropdownButton<String>
                    (

                      value: selectedOption,
                      onChanged: (newValue) 
                      {
                        setState(() 
                        {
                          selectedOption = newValue!;
                        });
                      },
                      items: options.map((option) 
                      {
                        return DropdownMenuItem<String>
                        (
                          value: option,
                          child: Text(option),
                        );
                        }).toList(),

                    ),


                    //forms
                    Column
                      (

                        children: 
                        [

                          //Single choice 
                          Visibility
                          (

                            visible: selectedOption == 'Single Choice',
                            child: Column
                            (

                              children: 
                              [

                                //question
                                Container
                                (

                                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),

                                  child: TextField
                                  (
                                    controller: single_choice_question_controller,

                                    decoration: const InputDecoration
                                    (

                                      hintText: 'Enter Question',
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

                                //option1
                                Container
                                (

                                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                  child: TextField
                                  (
                                    controller: option1_controller,

                                    decoration: const InputDecoration
                                    (

                                      hintText: 'Enter option 1',
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

                                //option 2
                                Container
                                (

                                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                  child: TextField
                                  (
                                    controller: option2_controller,

                                    decoration: const InputDecoration
                                    (

                                      hintText: 'Enter option 2',
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

                          //essay
                          Visibility
                          (

                            visible: selectedOption == 'Essay',
                            child: Column
                            (

                              children: 
                              [

                                TextField
                                (

                                  controller: essay_question_controller,

                                  decoration: const InputDecoration
                                  (

                                    hintText: 'Enter Question',
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

                                const TextField
                                (

                                  enabled: false,

                                  decoration: InputDecoration
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

                                TextField
                                (

                                  controller: rank_question_controller,

                                  decoration: const InputDecoration
                                  (

                                    hintText: 'Enter Question',
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

                          //Multiple choice
                          Visibility
                          (

                            visible: selectedOption == 'Multiple Choice',
                            child: Column
                            (

                              children: 
                              [

                                Container
                                (

                                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),

                                  child: TextField
                                  (
                                    controller: multiple_choice_controller,

                                    decoration: const InputDecoration
                                    (

                                      hintText: 'Enter Question',
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


                                //options
                                Column
                                (
                                  children: 
                                  [

                                    //option 1
                                    Container
                                    (
                                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                      child: TextField
                                      (
                                        controller: op1_controller,

                                        decoration: const InputDecoration
                                        (

                                          hintText: 'Enter option 1',
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


                                    //option 2
                                    Container
                                    (
                                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                      child: TextField
                                      (
                                        controller: op2_controller,

                                        decoration: const InputDecoration
                                        (

                                          hintText: 'Enter option 2',
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

                                    //add op3
                                    Visibility
                                    (
                                      visible: op3b == false,
                                      child: ElevatedButton
                                      (
                                        onPressed: () 
                                        {
                                          setState(() {
                                            op3b = true;
                                          });
                                        }, 
                                        child: const Text('add new option'),
                                      )
                                    ),

                                    //option 3
                                    Visibility
                                    (
                                      visible: op3b == true,
                                      child: Container
                                      (
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                        child: TextField
                                        (
                                          controller: op3_controller,

                                          decoration: const InputDecoration
                                          (

                                            hintText: 'Enter option 3',
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
                                      
                                    ),


                                    //add op4
                                    Visibility
                                    (
                                      visible: op3b ==true && op4b == false,
                                      child: ElevatedButton
                                      (
                                        onPressed: () 
                                        {
                                          setState(() {
                                            op4b = true;
                                          });
                                        }, 
                                        child: const Text('add new option'),
                                      )
                                    ),

                                    //option 4
                                    Visibility
                                    (
                                      visible: op4b == true,
                                      child: Container
                                      (
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                        child: TextField
                                        (
                                          controller: op4_controller,

                                          decoration: const InputDecoration
                                          (

                                            hintText: 'Enter option 4',
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
                                    ),


                                    //add op5
                                    Visibility
                                    (
                                      visible: op4b == true && op5b == false,
                                      child: ElevatedButton
                                      (
                                        onPressed: () 
                                        {
                                          setState(() {
                                            op5b = true;
                                          });
                                        }, 
                                        child: const Text('add new option'),
                                      )
                                    ),

                                    //option 5
                                    Visibility
                                    (
                                      visible: op5b == true,
                                      child: Container
                                      (
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                                        child: TextField
                                        (
                                          controller: op5_controller,

                                          decoration: const InputDecoration
                                          (

                                            hintText: 'Enter option 5',
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
                                    ),

                                  ],
                                ),

                              ],

                            )

                          ),

                        ],

                      ),

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
                      MaterialPageRoute(builder: (context) => Admnin_dashboard_page())
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