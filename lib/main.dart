
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String studentName, studentId, studyprogramId;
   String studentgpa;

   getstudetName(name){
     this.studentName = name;

   }
   getstudentID(id){
     this.studentId = id;
   }
   getprogramId(programID){
     this.studyprogramId = programID;
   }
   getGpa(gpa){
     this.studentgpa = gpa;
   }

   createData(){

     DocumentReference documentReference = Firestore.instance.
     collection("MyStudents").document(studentName);

     Map< String , dynamic> students = {
       "Student Name" : studentName,
       "Student ID" :studentId,
       "Study Program ID" : studyprogramId,
       "GPA" : studentgpa,
     };

     documentReference.setData(students).whenComplete(() {
       print("$studentName Created");
     });

   }
   updateData(){
     DocumentReference documentReference = Firestore.instance.
     collection("MyStudents").document(studentName);

     Map< String , dynamic> students = {
       "Student Name" : studentName,
       "Student ID" :studentId,
       "Study Program ID" : studyprogramId,
       "GPA" : studentgpa,
     };

     documentReference.setData(students).whenComplete(() {
       print("$studentName Updated");
     });

   }
   deleteData(){
     DocumentReference documentReference = Firestore.instance.
     collection("MyStudents").document(studentName);

     documentReference.delete().whenComplete(() {
       print("$studentName Deleted:");
     });

   }
   readData(){
     DocumentReference documentReference = Firestore.instance.
     collection("MyStudents").document(studentName);

     documentReference.get().then((datasnapshot){
     print(datasnapshot.data()["Student Name"]);
     print(datasnapshot.data()["Student ID"]);
     print(datasnapshot.data()["Study Program ID"]);
     print(datasnapshot.data()["GPA"]);
     });

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("My University App"),
      ),
       body: ListView(
         children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8.0),
                   child: TextFormField(
                     decoration: InputDecoration(
                       labelText: 'Name',
                       fillColor: Colors.white,
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.blue,
                           width: 3.0,
                         ),
                       ),
                     ),onChanged: (String name){
                     getstudetName(name);
                   },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8.0),
                   child: TextFormField(
                     decoration: InputDecoration(
                       labelText: 'Student ID',
                       fillColor: Colors.white,
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.blue,
                           width: 3.0,
                         ),
                       ),
                     ),onChanged: (String id){
                     getstudentID(id);
                   },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8.0),
                   child: TextFormField(
                     decoration: InputDecoration(
                       labelText: 'Study Program ID',
                       fillColor: Colors.white,
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.blue,
                           width: 3.0,
                         ),
                       ),
                     ),onChanged: (String programId){
                     getprogramId(programId);
                   },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8.0),
                   child: TextFormField(
                     decoration: InputDecoration(
                       labelText: 'GPA',
                       fillColor: Colors.white,
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.blue,
                           width: 3.0,
                         ),
                       ),
                     ),onChanged: (String gpa){
                     getGpa(gpa);

                   },
                   ),
                 ),

                 SizedBox(height: 15.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     RaisedButton(
                       color: Colors.green,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16.0),
                       ),
                       child: Text('Create',style: TextStyle(
                         color: Colors.white,
                       ),),
                       onPressed: (){
                         createData();
                       },
                     ),
                     RaisedButton(
                       color: Colors.blue,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16.0),
                       ),
                       child: Text('Read',style: TextStyle(
                         color: Colors.white,
                       ),),
                       onPressed: (){
                         readData();
                       },
                     ),
                     RaisedButton(
                       color: Colors.red,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16.0),
                       ),
                       child: Text('Update',style: TextStyle(
                         color: Colors.white,
                       ),),
                       onPressed: (){
                         updateData();
                       },
                     ),
                     RaisedButton(
                       color: Colors.amber,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16.0),
                       ),
                       child: Text('Delete',style: TextStyle(
                         color: Colors.white,
                       ),),
                       onPressed: (){
                         deleteData();
                       },
                     ),
                   ],
                 ),
                 SizedBox(height: 10.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Expanded(child: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                     Expanded(child: Text("Student ID",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                     Expanded(child: Text("Program ID",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                     Expanded(child: Text("GPA",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),



                   ],
                 ),
                 SizedBox(height: 15.0,),
                 StreamBuilder(
                   stream: Firestore.instance.collection("MyStudents").snapshots(),
                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                     if(snapshot.hasData){
                       return ListView.builder(
                         shrinkWrap: true,
                         itemCount: snapshot.data.documents.length,
                         itemBuilder: (context,index){
                           DocumentSnapshot documentsnapshot = snapshot.data.documents[index];

                           return  Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Expanded(child: Text(documentsnapshot["Student Name"])),
                               Expanded(child: Text(documentsnapshot["Student ID"])),
                               Expanded(child: Text(documentsnapshot["Study Program ID"])),
                               Expanded(child: Text(documentsnapshot["GPA"])),


                             ],
                           );
                         },
                       );
                     }
                   },
                 ),
               ],
             ),
           ),
         ],
       ),
    );
  }
}


