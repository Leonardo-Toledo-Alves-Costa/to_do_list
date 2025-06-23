import 'package:flutter/material.dart';
import 'package:to_do_list/components/new_to_do.dart';
import 'package:to_do_list/components/to_do.dart';
import 'package:to_do_list/services/auth/auth_service.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});

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
            Expanded(child: ToDo()),
            NewToDo(),
            ElevatedButton(
              onPressed: () {}, 
              child: Icon(Icons.add)
            )
          ],
        ),
      ),
    );
  }
}
