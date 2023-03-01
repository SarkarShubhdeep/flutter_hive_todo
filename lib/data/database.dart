import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // reference the box
  final myBox = Hive.box('myBox');

  // 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Buy caterpillar food', false],
      ['Flip the omelette', false],
    ];
  }

  // load the data from db
  void loadData() {
    toDoList = myBox.get('TODOLIST');
  }

  // update the db
  void updateDatabase() {
    myBox.put('TODOLIST', toDoList);
  }
}
