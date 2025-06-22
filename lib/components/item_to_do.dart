import 'package:flutter/material.dart';
import 'package:to_do_list/models/to_do_model.dart';

class ItemToDo extends StatelessWidget {
  final ToDoModel itemToDo;

  const ItemToDo({super.key, required this.itemToDo});

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