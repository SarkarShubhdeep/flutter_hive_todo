import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';

class AddTaskDialogBox extends StatelessWidget {
  // const AddTaskDialogBox({Key? key, this.taskController}) : super(key: key);

  final TextEditingController taskController;

  VoidCallback onSave;
  VoidCallback onCancel;

  AddTaskDialogBox(
      {super.key,
      required this.taskController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        decoration: BoxDecoration(),
        // height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Add a new task',
                fillColor: Colors.blue.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(buttonName: 'Cancel', onPressed: onCancel),
                MyButton(buttonName: 'Save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
