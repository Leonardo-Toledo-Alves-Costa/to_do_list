import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth/auth_mock_service.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('To Do List Page'),
            TextButton(
            onPressed: AuthMockService().logout, 
            child: Text('Sair da aplicação'),
            )
          ],
        ),
      ),
    );
  }
}