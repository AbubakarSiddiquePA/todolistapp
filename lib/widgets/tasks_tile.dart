import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;
//used below as anonymous function
  // void checkboxCallback(bool? checkboxState) {
  //   setState(() {
  //     isChecked = checkboxState ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Task ",
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: TaskCheckBox(
        checkboxState: isChecked,
        //used as anonymous function
        toggleCheckboxState: (bool? checkboxState) {
          setState(() {
            isChecked = checkboxState ?? false;
          });
        },
      ),
    );
  }
}

class TaskCheckBox extends StatelessWidget {
  final bool checkboxState;
  final void Function(bool?) toggleCheckboxState;
  const TaskCheckBox(
      {super.key,
      required this.checkboxState,
      required this.toggleCheckboxState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: checkboxState,
        onChanged: toggleCheckboxState);
  }
}
