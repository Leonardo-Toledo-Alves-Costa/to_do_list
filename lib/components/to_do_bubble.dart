import 'package:flutter/material.dart';
import 'package:to_do_list/models/to_do_model.dart';

class ToDoBubble extends StatelessWidget {
  final ToDoModel itemToDo;
  const ToDoBubble({super.key, required this.itemToDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(itemToDo.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10,),
          Text(itemToDo.text),
        ],
      ),
    );
  }
}