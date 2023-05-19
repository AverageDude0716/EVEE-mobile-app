import 'package:evee/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'styles.dart';


class Create_voter_page extends StatefulWidget
{

    @override
    State<Create_voter_page> createState() => _Create_voter_page_state();

}

class _Create_voter_page_state extends State<Create_voter_page>
{

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

                //height: screenHeight,
                width: screenWidth,

                decoration: const BoxDecoration
                (

                  image: DecorationImage
                  (
                    image: AssetImage('assets/background_img/background_1.jpg'),
                    fit: BoxFit.cover,
                  )

                ),


                child: GestureDetector
                (

                    onTap: () 
                    {
                      FocusScope.of(context).unfocus();
                    },

                    child: Container
                    (

                      //form design
                      //height: screenHeight,
                      width: screenWidth,
                      margin: const EdgeInsets.all(30.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration
                      (

                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)

                      ),

                      child: Column
                      (

                        children: 
                        [

                          //header
                          const Text
                          (
                            'Create a Voter Account',
                            style: TextStyle
                            (
                              color: Colors.black,
                              fontSize: 38.0,
                              decoration: TextDecoration.none
                            ),
                          ),//header

                          //last name and first name textfield
                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(0, 100.0, 0, 0),

                            child: Row
                            (

                              children: 
                              [

                                // last name
                                Expanded
                                (
                                  flex: 5,

                                  child: Container
                                  (
                                    margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),

                                    child: const TextField
                                    (

                                      decoration: InputDecoration
                                      (

                                        hintText: 'last name',
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
                                  )
                                ),

                                //first name
                                Expanded
                                (
                                  flex: 5,

                                  child: Container
                                  (
                                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),

                                    child: const TextField
                                    (

                                      decoration: InputDecoration
                                      (

                                        hintText: 'first name',
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
                                  )
                                )

                              ],

                            )

                          ),

                          //birthdate
                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),

                            child: TextField
                            (

                              decoration: const InputDecoration
                              (

                                hintText: 'Enter birthdate (YYYYMMDD)',
                                border: OutlineInputBorder
                                (
                                  borderSide: BorderSide(color: light_gray),
                                ),
                                enabledBorder: OutlineInputBorder
                                (
                                  borderSide: BorderSide(color: light_gray),
                                ),

                              ),

                              keyboardType: TextInputType.datetime,
                              inputFormatters: 
                              [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(8),
                                // You can add a custom date input formatter here
                              ],

                            ),

                          ),

                          //gender
                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),

                            child: const TextField
                            (

                              decoration: InputDecoration
                              (

                                hintText: 'Enter Gender (Male, Female, Other)',
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

                          //email textfield
                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),

                            child: const TextField
                            (

                              decoration: InputDecoration
                              (

                                hintText: 'Enter E-mail',
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

                          //password textfield
                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),

                            child: TextField
                                  (

                                    obscureText: true,
                                    decoration: InputDecoration
                                    (
                                      hintText: 'Enter Password',

                                      border: const OutlineInputBorder
                                      (
                                        borderSide: BorderSide(color: light_gray),
                                        
                                      ),

                                      enabledBorder: const OutlineInputBorder
                                      (
                                        borderSide: BorderSide(color: light_gray)
                                      ),

                                      suffixIcon: IconButton
                                      (
                                        onPressed: () {},
                                        icon: const Icon(Icons.visibility)
                                      )
                                    ),
                                    

                                  ),

                          ),

                          //confirm password
                          Container
                          (

                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 100),

                            child: TextField
                                  (

                                    obscureText: true,
                                    decoration: InputDecoration
                                    (
                                      hintText: 'Confirm Password',

                                      border: const OutlineInputBorder
                                      (
                                        borderSide: BorderSide(color: light_gray),
                                        
                                      ),

                                      enabledBorder: const OutlineInputBorder
                                      (
                                        borderSide: BorderSide(color: light_gray)
                                      ),

                                      suffixIcon: IconButton
                                      (
                                        onPressed: () {},
                                        icon: const Icon(Icons.visibility)
                                      )
                                    ),
                                    

                                  ),

                          ),

                          // create account button
                          ElevatedButton
                          (
                            onPressed: () {},
                            child: const Text('Create Account')
                          ),

                          //to login
                          ElevatedButton
                          (
                            onPressed: () 
                            {

                              Navigator.push
                              (
                                context, 
                                MaterialPageRoute(builder: (context) => Login_page())
                              );

                            },
                            child: const Text('Already have an account? Login')
                          )
      
                        ],

                      ),

                    ),

                ),//form

              ),

      ),

    );

  }

}