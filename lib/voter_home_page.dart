import 'package:evee/landing_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Voter_home_page extends StatefulWidget
{

    @override
    State<Voter_home_page> createState() => _Voter_home_page_state();

}

class _Voter_home_page_state extends State<Voter_home_page>
{
  TextEditingController poll_id_input_controller = TextEditingController();


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
                  borderRadius: BorderRadius.circular(20.0)

                ),

                child: TextField
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

              ),


              //poll header
              Container
              (
                child: const Text('polls'),
              ),


              //list
              Container
              (

                child: ListView.builder
                (
                  itemBuilder: (BuildContext context, int index) 
                  {

                    
                  }
                )

              ),

              
              
            ],

          ),

        ),

      ),

    );

  }

}