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
  String selectedOption = 'Option 1';
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  
  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold
    (

      body: SingleChildScrollView
      (

        child: Container
        (

          color: light_yellow,
          width: screenWidth,

            child: DropdownButton<String>
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
        ),

      ),
      
    );

  }

}