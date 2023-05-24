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
  String selectedOption = 'Multiple Choice';
  List<String> options = ['Multiple Choice', 'Essay', 'Rank Choice', 'Single Choice'];

  TextEditingController poll_name_controller  = TextEditingController();

  TextEditingController multiple_choice_question_controller = TextEditingController();
  TextEditingController option1_controller = TextEditingController();
  TextEditingController option2_controller = TextEditingController();

  TextEditingController essay_question_controller = TextEditingController();

  
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

                                  child: TextField
                                  (
                                    controller: multiple_choice_question_controller,

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

                              ],

                            )

                          ),

                          //rank
                          Visibility
                          (

                            visible: selectedOption == 'Rank Choice',
                            child: Text('rank')

                          ),

                          //single
                          Visibility
                          (

                            visible: selectedOption == 'Single Choice',
                            child: Text('Single')

                          ),

                        ],

                      ),

                  ],

                ),

              ),

              //save
              Container(),

              //cancel
              Container(),

            ],

          ),

        ),

      ),
      
    );

  }

}