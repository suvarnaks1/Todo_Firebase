import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addtaskpage.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var uid  ;
  

  @override
  void initState() {
    // TODO: implement initState
           uid = FirebaseAuth.instance.currentUser?.uid;

    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("client").doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            var tasksData = snapshot.data?.data() ?? {};
          // List tasksList = tasksData['tasks'] ?? [];
List<TaskModel> tasksList = (tasksData['tasks'] as List<dynamic>? ?? []).map((taskData) {
                    return TaskModel(
                      task: taskData['task'] ?? "",
                      subTask: taskData['subTask'] ?? "",
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: tasksList.length,
                    itemBuilder: (context, index) {
                       String documentId = snapshot.data!.id;
                        // Map<String, dynamic>? data = tasksList[index] as Map<String, dynamic>?;

  print("Document ID: $documentId");
   





                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage:
                                      AssetImage('assets/smile.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                  tasksList[index].task,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                  
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 160.0,
                                top: 5.0,
                              ),
                              child: Text(
                                tasksList[index].subTask,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}


class TaskModel {
  final String task;
  final String subTask;

  TaskModel({required this.task, required this.subTask});
}
