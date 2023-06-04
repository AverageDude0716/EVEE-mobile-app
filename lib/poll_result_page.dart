import 'package:evee/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;


/*
class Poll_result_page extends StatefulWidget
{
  final String id;

  Poll_result_page({required this.id});


    @override
    State<Poll_result_page> createState() => _Poll_result_page_state();

}


class BarChartData 
{
  final String category;
  final int value;

  BarChartData(this.category, this.value);
}



class _Poll_result_page_state extends State<Poll_result_page>
{
  FirebaseAuth auth = FirebaseAuth.instance;


  late Future<List<String>> poll_info;
  late  Future<List<List<dynamic>>>  question_info;

  List<BarChartData> data = [];


  Future<List<dynamic>> get_user_info(String id) async
  {

    DocumentReference docref = FirebaseFirestore.instance.collection('users').doc(id);

    List<dynamic> info = [];

    await docref.get().then((DocumentSnapshot documentSnapshot) 
    {

      Map<String, dynamic>? data2 = documentSnapshot.data() as Map<String, dynamic>?;
      if(data2 != null)
      {
        String ln = data2['last name'];
        String fn = data2['first name'];
        String gender = data2['gender'];
      }

    }).catchError((error)
    {

    });   

    return info;  
  
  }


  Future<List<String>>  get_poll(String id) async
  {

    DocumentReference docref = FirebaseFirestore.instance.collection('polls').doc(id);

    List<String> info = [];

    await docref.get().then((DocumentSnapshot documentSnapshot) 
    async {

      if(documentSnapshot.exists)
      {

        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if(data != null)
        {

          String name = data['poll name'];
          String id = data['poll id'];
          String owner = data["poll owner"];
          String poll_owner = 'pl';

          await FirebaseFirestore.instance.collection('users').doc(owner).get()
          .then((DocumentSnapshot snapshot) 
          {
            Map<String, dynamic>? data2 = snapshot.data() as Map<String, dynamic>?;
            if(data2 != null)
            {
              String ln = data2['last name'];
              String fn = data2['first name'];
              poll_owner = '$fn $ln';
            }
          }).catchError((error) 
          {

          });

          info.add(name);
          info.add(id);
          info.add(poll_owner);

        }

      }

    }).catchError((error)
    {

    });

    return info;

  }

  
  Future<List<List<dynamic>>> get_question(String id) async
  {


    CollectionReference collref = FirebaseFirestore.instance.collection('polls').doc(id).collection('questions');

    List<List<dynamic>> questions = [];
    List<dynamic> info = [];
    List<String> users = [];

    QuerySnapshot snapshot = await collref.get();

    for(var doc in snapshot.docs)
    {

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      String type = data['type'];
      String question = data['question'];
      String responders = data['responders'];

      info.add(type);
      info.add(question);
      info.add(responders);
      
      List<String> respondentsList = responders
              .split('/')
              .where((respondentsList) => respondentsList.isNotEmpty)
              .toList();

      users += respondentsList;        

      switch(type)
      {

        case 'Multiple Choice':
          String op1 = data['option 1'];
          dynamic op1_res= data['option 1 responses'];

          String op2 = data['option 2'];
          dynamic op2_res = data['option 2 responses'];

          info.add(op1);
          info.add(op1_res);
          info.add(op2);
          info.add(op2_res);
          break;

        case 'Essay':
          dynamic responses = data['responses'];
          String answer = 'answer $responses';

          info.add(responses);

          for(int x = 0; x < responses; x++)
          {

            String ans = data[answer];

            info.add(ans);
          }
          break;  

        case 'Rank Choice':
          dynamic rank1 = data['rank 1 responses'];
          dynamic rank2 = data['rank 2 responses'];
          dynamic rank3 = data['rank 3 responses'];
          dynamic rank4 = data['rank 4 responses'];

          info.add(rank1);
          info.add(rank2);
          info.add(rank3);
          info.add(rank4);
          break;    

      }

      List<String> new_list = users.toSet().toList();
      
      users = new_list;

      questions.add(info);

    }

    return questions;


  }


  @override
  void initState() {
    super.initState();

    poll_info = get_poll(widget.id);
    question_info = get_question(widget.id);

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

        child: Column
        (

          mainAxisSize: MainAxisSize.min,

          children: 
          [

            //header
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
              

              child: FutureBuilder<List<String>>
              (

                future: poll_info,
                builder: (context, snapshot) 
                {

                  if (snapshot.connectionState == ConnectionState.waiting) 
                  {
                    // Show a loading indicator while data is being fetched
                    return const CircularProgressIndicator();
                  } 
                  else if (snapshot.hasError) 
                  {
                    // Handle error case
                    return Text('Error: ${snapshot.error}');

                  } 
                  else if (snapshot.hasData) 
                  {
                    // Data retrieval is successful
                    List<String> data = snapshot.data!;

                    String name = data[0];
                    String id = data[1];
                    String owner = data[2];

                    return Column
                    (

                      children: 
                      [

                        Text('Poll Name: $name'),

                        Text('Poll Owner: $owner'),

                        const Text('Poll ID'),

                        Text(id),

                      ],

                    );
                    

                  } else {
                    // Data is null
                    return Text('No data found.');
                  }

                },
              ),

            ),

            //general data
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

              child: FutureBuilder<List<List<dynamic>>>
              (

                future: question_info,
                builder: (context, snapshot) 
                {

                  if (snapshot.connectionState == ConnectionState.waiting) 
                  {
                    // Show a loading indicator while data is being fetched
                    return const CircularProgressIndicator();
                  } 
                  else if (snapshot.hasError) 
                  {
                    // Handle error case
                    return Text('Error: ${snapshot.error}');

                  } 
                  else if (snapshot.hasData) 
                  {
                    // Data retrieval is successful
                    List<List<dynamic>> data = snapshot.data!;
                    int total = 0;
                    
                    for(List<dynamic> list in data)
                    {

                      String type = list[0];
                      int subtotal = 0;

                      switch(type)
                      {

                        case 'Multiple Choice':
                          int op1 = list[4];
                          int op2 = list[6];

                          subtotal = op1 + op2;
                          total += subtotal;
                          break;

                         case 'Essay':
                          int respo = list[3];

                          total += respo;
                          break; 

                        case 'Rank Choice':
                          int r1 = list[3];
                          int r2 = list[4];
                          int r3 = list[5];
                          int r4 = list[6];

                          subtotal = r1 + r2 + r3+ r4;
                          total += subtotal;
                          break;  

                      }

                    }
                    

                    return Container
                    (

                      child: Text('$total'),

                    );
                    

                  } else {
                    // Data is null
                    return Text('No data found.');
                  }

                },
              ),

            ),


            //question results
            Container
            (



            ),

          ],

        ),

      ),


    );

  }

}
*/

class Poll_result_page extends StatefulWidget 
{
  final String id;

  Poll_result_page({required this.id});

  @override
  State<Poll_result_page> createState() => _Poll_result_page_state();
}

class BarChartData 
{
  final String category;
  final int value;

  BarChartData(this.category, this.value);
}

class _Poll_result_page_state extends State<Poll_result_page>
 {
  FirebaseAuth auth = FirebaseAuth.instance;

  late Future<List<String>> poll_info;
  late Future<List<List<dynamic>>> question_info;

  List<BarChartData> data = [];

  Future<List<dynamic>> get_user_info(String id) async {
    DocumentReference docref =
        FirebaseFirestore.instance.collection('users').doc(id);

    List<dynamic> info = [];

    await docref.get().then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic>? data2 =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (data2 != null) {
        String ln = data2['last name'];
        String fn = data2['first name'];
        String gender = data2['gender'];
      }
    }).catchError((error) {});

    return info;
  }

  Future<List<String>> get_poll(String id) async {
    DocumentReference docref =
        FirebaseFirestore.instance.collection('polls').doc(id);

    List<String> info = [];

    await docref.get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          String name = data['poll name'];
          String id = data['poll id'];
          String owner = data["poll owner"];
          String poll_owner = 'pl';

          await FirebaseFirestore.instance
              .collection('users')
              .doc(owner)
              .get()
              .then((DocumentSnapshot snapshot) {
            Map<String, dynamic>? data2 =
                snapshot.data() as Map<String, dynamic>?;
            if (data2 != null) {
              String ln = data2['last name'];
              String fn = data2['first name'];
              poll_owner = '$fn $ln';
            }
          }).catchError((error) {});

          info.add(name);
          info.add(id);
          info.add(poll_owner);
        }
      }
    }).catchError((error) {});

    return info;
  }

  Future<List<List<dynamic>>> get_question(String id) async {
    CollectionReference collref =
        FirebaseFirestore.instance.collection('polls').doc(id).collection('questions');

    List<List<dynamic>> questions = [];
    List<dynamic> info = [];
    List<String> users = [];

    QuerySnapshot snapshot = await collref.get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      String type = data['type'];
      String question = data['question'];
      String responders = data['responders'];

      info.add(type);
      info.add(question);
      info.add(responders);

      List<String> respondentsList = responders
          .split('/')
          .where((respondentsList) => respondentsList.isNotEmpty)
          .toList();

      users += respondentsList;

      switch (type) 
      {
        case 'Multiple Choice':
          String op1 = data['option 1'];
          dynamic op1_res = data['option 1 responses'];

          String op2 = data['option 2'];
          dynamic op2_res = data['option 2 responses'];

          info.add(op1);
          info.add(op1_res);
          info.add(op2);
          info.add(op2_res);
          break;

        case 'Essay':
          int responses = data['responses'];
          
          int num = 0;

          info.add(responses);

          for (int x = 0; x < responses; x++) 
          {
            num++;
            String answer = 'answer $num';
            String ans = data[answer];
            info.add(ans);
          }
          break;

        case 'Rank Choice':
          dynamic rank1 = data['rank 1 responses'];
          dynamic rank2 = data['rank 2 responses'];
          dynamic rank3 = data['rank 3 responses'];
          dynamic rank4 = data['rank 4 responses'];

          info.add(rank1);
          info.add(rank2);
          info.add(rank3);
          info.add(rank4);
          break;
      }
      String question_id = doc.id;

      info.add(question_id);

      List<String> new_list = users.toSet().toList();
      users = new_list;

      questions.add(info);
    }

    return questions;
  }

  @override
  void initState() {
    super.initState();
    poll_info = get_poll(widget.id);
    question_info = get_question(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //header
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(20),
              width: screenWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: light_yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder<List<String>>(
                future: poll_info,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while data is being fetched
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle error case
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // Data retrieval is successful
                    List<String> data = snapshot.data!;

                    String name = data[0];
                    String id = data[1];
                    String owner = data[2];

                    return Column(
                      children: [
                        Text('Poll Name: $name'),
                        Text('Poll Owner: $owner'),
                        const Text('Poll ID'),
                        Text(id),
                      ],
                    );
                  } else {
                    // Data is null
                    return Text('No data found.');
                  }
                },
              ),
            ),

            //general data
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(20),
              width: screenWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: light_yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder<List<List<dynamic>>>(
                future: question_info,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while data is being fetched
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle error case
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // Data retrieval is successful
                    List<List<dynamic>> data = snapshot.data!;
                    int total = 0;

                    for (List<dynamic> list in data) {
                      String type = list[0];
                      int subtotal = 0;

                      switch (type) {
                        case 'Multiple Choice':
                          int op1 = list[4];
                          int op2 = list[6];

                          subtotal = op1 + op2;
                          total += subtotal;
                          break;

                        case 'Essay':
                          int respo = list[3];
                          total += respo;
                          break;

                        case 'Rank Choice':
                          int r1 = list[3];
                          int r2 = list[4];
                          int r3 = list[5];
                          int r4 = list[6];

                          subtotal = r1 + r2 + r3 + r4;
                          total += subtotal;
                          break;
                      }
                    }

                    return Container(
                      child: Text('$total'),
                    );
                  } else {
                    // Data is null
                    return Text('No data found.');
                  }
                },
              ),
            ),

            //question results
            Container
            (
              child: FutureBuilder<List<List<dynamic>>>(
                future: question_info,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) 
                  {
                    // Show a loading indicator while data is being fetched
                    return const CircularProgressIndicator();
                  } 
                  else if (snapshot.hasError) 
                  {
                    // Handle error case
                    return Text('Error: ${snapshot.error}');
                  } 
                  else if (snapshot.hasData) 
                  {
                    // Data retrieval is successful
                    List<List<dynamic>> data = snapshot.data!;

                    return ListView.builder
                    (
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index)
                      {
                        List<dynamic> question = data[index];
                        String type = question[0];
                        String questionText = question[1];
                        String responders = question[2];
                        List<String> respondentsList = responders
                            .split('/')
                            .where((respondentsList) => respondentsList.isNotEmpty)
                            .toList();

                        List<dynamic> answers = question.sublist(4, question.length-1);
                        
                        return Container
                        (
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration
                          (
                            color: light_yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column
                          (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: 
                            [
                              Text('Question: $questionText'),
                              Text('Type: $type'),
                              Text('Total Responders: ${respondentsList.length}'),
                              if (type == 'Multiple Choice')
                                _buildMultipleChoiceChart(question),
                              if (type == 'Rank Choice')
                                _buildRankChoiceChart(question),
                              if (type == 'Essay')
                               
                                _buildEssayResponses(answers),
                            ],
                          ),
                        );
                      },
                    );
                  } else 
                  {
                    // Data is null
                    return Text('No data found.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceChart(List<dynamic> question) 
  {
    String option1 = question[3];
    int option1Responses = question[4];
    String option2 = question[5];
    int option2Responses = question[6];

    List<BarChartData> data = 
    [
      BarChartData(option1, option1Responses),
      BarChartData(option2, option2Responses),
    ];

    List<charts.Series<BarChartData, String>> series = 
    [
      charts.Series
      (
        id: 'Multiple Choice',
        data: data,
        domainFn: (BarChartData data, _) => data.category,
        measureFn: (BarChartData data, _) => data.value,
      ),
    ];

    return Container
    (
      height: 200,
      child: charts.BarChart
      (
        series,
        animate: true,
        vertical: false,
      ),
    );
  }

  Widget _buildRankChoiceChart(List<dynamic> question) 
  {
    int rank1Responses = question[3];
    int rank2Responses = question[4];
    int rank3Responses = question[5];
    int rank4Responses = question[6];

    List<BarChartData> data = 
    [
      BarChartData('Rank 1', rank1Responses),
      BarChartData('Rank 2', rank2Responses),
      BarChartData('Rank 3', rank3Responses),
      BarChartData('Rank 4', rank4Responses),
    ];

    List<charts.Series<BarChartData, String>> series = 
    [
      charts.Series
      (
        id: 'Rank Choice',
        data: data,
        domainFn: (BarChartData data, _) => data.category,
        measureFn: (BarChartData data, _) => data.value,
      ),
    ];

    return Container
    (
      height: 200,
      child: charts.BarChart
      (
        series,
        animate: true,
        vertical: false,
      ),
    );
  }

  /*Widget _buildEssayResponses(List<String> respondentsList) 
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: respondentsList.map((response) => Text(response)).toList(),
    );
  }*/

  Widget _buildEssayResponses(List<dynamic> respondentsList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: respondentsList.map((response) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(response, style: TextStyle(color: Colors.white)),
      )).toList(),
    );
  }
}


