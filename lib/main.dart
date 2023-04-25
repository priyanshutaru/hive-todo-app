// ignore_for_file: unnecessary_import, depend_on_referenced_packages, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory document = await getApplicationDocumentsDirectory();

  Hive.init(document.path);

  await Hive.openBox("students");

  runApp(MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController rollNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Box? studentBox;

  @override
  void initState() {
    studentBox = Hive.box("students");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive ToDo")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder(
              valueListenable: studentBox!.listenable(),
              builder: (context, Box studentBox, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: studentBox.keys.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Task ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(studentBox.keyAt(index)),
                            Text(
                              " : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: Text(studentBox.getAt(index))),
                          ],
                        ),
                      )

                          // ListTile(
                          //   title: Text(studentBox.keyAt(index)),
                          //   subtitle: Text(studentBox.getAt(index)),
                          // ),
                          );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: rollNoController,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: nameController,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        studentBox?.put(rollNoController.text,
                                            nameController.text);
                                        rollNoController.clear();
                                        nameController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("submit"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Add Task")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow, // Background color
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: rollNoController,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: nameController,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        studentBox?.put(rollNoController.text,
                                            nameController.text);
                                        rollNoController.clear();
                                        nameController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("submit"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Update Task")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50,
                                          left: 8,
                                          right: 8,
                                          bottom: 8),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: rollNoController,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        studentBox
                                            ?.delete(rollNoController.text);
                                        rollNoController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("submit"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Delete Task")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, // Background color
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50,
                                          left: 8,
                                          right: 8,
                                          bottom: 8),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: rollNoController,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        print(studentBox
                                            ?.get(rollNoController.text));

                                        rollNoController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("submit"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Show Task In Terminal")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
