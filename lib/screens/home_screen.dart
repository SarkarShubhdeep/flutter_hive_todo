import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';

import '../utils/add_task_dialog_box.dart';
import '../utils/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // reference the Hive box
  final myBox = Hive.box('myBox');

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // first time opening the app -> create default data
    if (myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // not the first time -> load existing data
      db.loadData();
    }

    super.initState();
  }

  final TextEditingController taskController = TextEditingController();

  // list of tasks
  // List toDoList = [
  //   ['task 1', false],
  //   ['task 2', false],
  //   ['task 3', false],
  // ];

  void onTaskChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([taskController.text, false]);
      taskController.clear();
      // print(taskController.text);
    });
    db.updateDatabase();
    Navigator.pop(context);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialogBox(
          taskController: taskController,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0,
        title: Text('To do'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => onTaskChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
