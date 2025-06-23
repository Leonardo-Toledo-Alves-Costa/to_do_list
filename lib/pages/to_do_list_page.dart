import 'dart:math';
import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth/auth_service.dart';
import 'package:to_do_list/components/item_to_do.dart';
import 'package:to_do_list/models/to_do_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<ToDoModel> _items = [];

  void _showAddItemDialog() {
    final user = AuthService().currentUser;

    final titleController = TextEditingController();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Novo Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && textController.text.isNotEmpty) {
                setState(() {
                  _items.add(ToDoModel(
                    userName: user.name,
                    userID: user.id,
                    userImageURL: user.imageURL,
                    createdAt: DateTime.now(),
                    id: Random().nextDouble().toString(),
                    title: titleController.text,
                    text: textController.text,
                  ));
                });
                Navigator.of(context).pop();
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Asimovianas'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) => ItemToDo(itemToDo: _items[index]),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _showAddItemDialog,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}