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

  int _selectedIndex = 0;  
  static const List<Widget> _widgetOptions = <Widget>
  [  
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
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

      body: Center
      (
       
        child: _widgetOptions.elementAt(_selectedIndex)

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
            backgroundColor: light_pink  
          ), 

          BottomNavigationBarItem(  
            icon: Icon(Icons.settings),  
            label: 'Settings',  
            backgroundColor: light_blue  
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