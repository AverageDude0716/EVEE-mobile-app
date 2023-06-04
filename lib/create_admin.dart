import 'package:evee/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:evee/login.dart';
import 'package:evee/firebase_functions.dart';
import 'package:flutter/services.dart';
import 'package:evee/admin_home_page.dart';
import 'styles.dart';


class Create_admin_page extends StatefulWidget
{

    @override
    State<Create_admin_page> createState() => _Create_admin_page_state();

}

class _Create_admin_page_state extends State<Create_admin_page>
{
TextEditingController last_name_controller = TextEditingController();
  TextEditingController first_name_controller = TextEditingController();
  TextEditingController birthdate_controller = TextEditingController();
  TextEditingController gender_controller = TextEditingController();
  TextEditingController email_contoller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();

  Firebase_func firebase_func = Firebase_func();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void _signup_button_press()
  {
    
    String last_name = last_name_controller.text;
    String first_name = first_name_controller.text;
    String birth_date_string = birthdate_controller.text;
    String gender = gender_controller.text;
    String email = email_contoller.text;
    String password = password_controller.text;
    String confirm_password = confirm_password_controller.text;

    if(last_name.isNotEmpty && first_name.isNotEmpty && birth_date_string.isNotEmpty
    && gender.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirm_password.isNotEmpty)
    {

      int birth_date = int.parse(birth_date_string);

      if(gender == 'Male' || gender == 'Female'|| gender == 'male' || gender == 'female' || gender == 'other' || gender == 'Other')
      {

        if(email.contains('@') && email.contains('.'))
        {

          if(password.length > 6 )
          {

            if(confirm_password == password)
          {

            try
            {
              firebase_func.signUpWithEmailAndPassword(last_name, first_name, birth_date, gender,'admin', email, password);
            }
            catch(e)
            {
              SnackBar snackBar = SnackBar
              (
                content: Text('Sign Up failed. $e' ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            finally
            {

              Navigator.push
                (
                  context,
                  MaterialPageRoute(builder: (context) => Admnin_dashboard_page())
                );

            }

          }
          else
          {
            const SnackBar snackBar = SnackBar
            (
              content: Text('Please confirm your password'),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          }
          else
          {

            const SnackBar snackBar = SnackBar
            (
              content: Text('Please enter a stronger password (Must be at least 6 characters long)'),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }

        }
        else
        {
          const SnackBar snackBar = SnackBar
          (
            content: Text('Enter a valid e-mail'),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      }
      else
      {
        const SnackBar snackBar = SnackBar
      (
        content: Text('Inavlid input at Gender. (Male, Female, Others)'),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }
    else
    {
      const SnackBar snackBar = SnackBar
      (
        content: Text('Fill up all fields'),
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

      body: WillPopScope
      (
        onWillPop: ()async
        {
          return false;
        },

        child: SingleChildScrollView
      (

        child: Container
              (

                //height: screenHeight,
                width: screenWidth,

                decoration: const BoxDecoration
                (

                    image: DecorationImage
                    (
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                    )
                    /*gradient: LinearGradient
                    (
                      colors: 
                      [
                        blue2,
                        purple2,
                        yellow2,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )*/

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
                            'Create a Admin Account',
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

                                    child:  TextField
                                    (
                                      controller: last_name_controller,
                                      decoration: const InputDecoration
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

                                    child: TextField
                                    (
                                      controller: first_name_controller,

                                      decoration: const InputDecoration
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
                              controller: birthdate_controller,

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

                            child: TextField
                            (
                              controller: gender_controller,

                              decoration: const InputDecoration
                              (

                                hintText: 'Enter Gender (Male, Female, Others)',
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

                            child: TextField
                            (
                              controller: email_contoller,

                              decoration: const InputDecoration
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
                                    controller: password_controller,
                                    obscureText: obscurePassword,
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
                                        onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                        });
                                      },
                                      icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
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
                                    controller: confirm_password_controller,
                                    obscureText: obscureConfirmPassword,
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
                                        onPressed: () {
                                        setState(() {
                                          obscureConfirmPassword = !obscureConfirmPassword;
                                        });
                                      },
                                      icon: Icon(obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                                      )
                                    ),
                                    

                                  ),

                          ),

                          // create account button
                          ElevatedButton
                          (
                            onPressed: () 
                            {

                              _signup_button_press();

                            },
                            style: const ButtonStyle
                            (
                              backgroundColor: MaterialStatePropertyAll(purple2),
                            ),
                            child: const Text('Create Account')
                          ),

                          //to login
                          OutlinedButton
                          (
                            onPressed: () 
                            {

                              Navigator.push
                              (
                                context, 
                                MaterialPageRoute(builder: (context) => Login_page())
                              );

                            },
                              child: const Text('Already have an account? Login', style: TextStyle(color: Colors.black),)
                          )
      
                        ],

                      ),

                    ),

                ),//form

              ),

      ),


      )

    );

  }

}