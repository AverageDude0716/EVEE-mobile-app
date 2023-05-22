import 'package:evee/admin_home_page.dart';
import 'package:evee/admin_profile_page.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/settings_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Admnin_dashboard_page extends StatefulWidget
{

    @override
    State<Admnin_dashboard_page> createState() => _Admnin_dashboard_page_state();

}

class _Admnin_dashboard_page_state extends State<Admnin_dashboard_page>
{
  int _selectedIndex = 0;  
  

  static final List<Widget> _widgetOptions = <Widget>
  [  

    Admnin_home_page(),
    Admin_profile_page(),
    Settings_page(),
    
  ];  

  
  void _onItemTapped(int index) 
  {  
    setState(() 
    {  
      _selectedIndex = index;  
    });  
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

        child: Container
        (

          color: light_yellow,
          width: screenWidth,

          child: _widgetOptions.elementAt(_selectedIndex),

        ),

      ),


      bottomNavigationBar:  BottomNavigationBar
      (  
        items: const <BottomNavigationBarItem>
        [  

          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Home',  
            backgroundColor: light_violet 
          ), 

          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label: 'Profile',  
            backgroundColor: light_violet 
          ), 

          BottomNavigationBarItem(  
            icon: Icon(Icons.settings),  
            label: 'Settings',  
            backgroundColor: light_violet 
          ),  

        ], 

        type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  ,
      )

    );

  }

}