import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:welcome_todo/welcomepage.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskName = TextEditingController();
  final TextEditingController subtaskName = TextEditingController();

  Future<void> addTask(String taskName, String subTaskName) async {
    try {
      var taskData = {
        'task': taskName,
        'subTask': subTaskName,
      };

      var uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        var collRef = FirebaseFirestore.instance.collection('client').doc(uid);

        var userDoc = await collRef.get();
        if (!userDoc.exists) {
          await collRef.set({'tasks': []});
        }

        var tasksList = (userDoc.data()?['tasks'] ?? []) as List<dynamic>;
        tasksList.add(taskData);

        await collRef.update({'tasks': tasksList});

        print("Data added successfully!");
      } else {
        print("User not authenticated.");
      }
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('ADD YOUR TASK')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: taskName,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your task',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: subtaskName,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add sub details',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addTask(taskName.text, subtaskName.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}






















//  String? dt = DateTime.now().toString();

//  Future<void> addtofirebase() async {
//     print('printtttt');
//     FirebaseAuth auth = await FirebaseAuth.instance;
//     final User? user = await auth.currentUser;
//     String uid = user!.uid;
//     var currentTime = DateTime.now();
//     try {
//       await FirebaseFirestore.instance
//           .collection("Todo")
//           .doc(uid)
//           .collection('Mytaskes')
//           // .doc(currentTime.toString())
//           .add({
//         'Task': _taskController.text,
//         'Subtasks': _subDetailsController.text,
//         // 'Priority': selectedPriority,
//         // 'Date': formatDate(currentTime),
//         // 'Time': formatTime(currentTime),
//         // 'Date': dateContoller.text,
//         // 'Time': timeContoller.text
//       });
//       print("Uploaded");
//     } catch (e) {
//       print("Error uploading task: $e");
//       print("errorrrrrrrr");
//     }
//   }

