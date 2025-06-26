import 'package:flutter/material.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/auth/auth_service.dart';
import 'package:to_do_list/services/to_do_list/to_do_service.dart';

class NewToDo extends StatefulWidget {
  final void Function(ToDoModel)? onAdd;
  const NewToDo({super.key, this.onAdd});

  @override
  State<NewToDo> createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  final titleController = TextEditingController();
  final textController = TextEditingController();


  Future<void> _addItem() async {
    final user = AuthService().currentUser;
    if (titleController.text.isNotEmpty && textController.text.isNotEmpty) {
      final newItem = ToDoModel(
        userName: user.name,
        userID: user.id,
        userImageURL: user.imageURL,
        createdAt: DateTime.now(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        text: textController.text,
      );
    await ToDoService().save(newItem, user);
    if(widget.onAdd != null){
    widget.onAdd!(newItem);
    }
    titleController.clear();
    textController.clear();
    if(mounted){
      Navigator.of(context).pop();
      }
    }
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Novo Item',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text('Novo Item'),
      onPressed: _showAddItemDialog,
    );
  }
}