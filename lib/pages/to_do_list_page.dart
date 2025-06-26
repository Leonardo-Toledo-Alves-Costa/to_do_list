import 'package:flutter/material.dart';
import 'package:to_do_list/components/new_to_do.dart';
import 'package:to_do_list/components/to_do_bubble.dart';
import 'package:to_do_list/services/auth/auth_service.dart';
import 'package:to_do_list/models/to_do_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<ToDoModel> _items = [];
  final newItem = NewToDo();

    void _addNewItem(ToDoModel item) {
    setState(() {
      _items.add(item);
    });
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
                itemCount: _items.length ,
                itemBuilder: (context, index) => ToDoBubble(itemToDo: _items[index]),
              ),
            ),
            SizedBox(height: 10),
            NewToDo(onAdd: _addNewItem),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}