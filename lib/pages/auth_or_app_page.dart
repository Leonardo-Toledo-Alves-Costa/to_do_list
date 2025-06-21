import 'package:flutter/material.dart';
import 'package:to_do_list/pages/auth_page.dart';
import 'package:to_do_list/pages/loading_page.dart';
import 'package:to_do_list/pages/to_do_list_page.dart';
import 'package:to_do_list/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: AuthService().userChanges, 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingPage();
          }else{
            return snapshot.hasData ? ToDoListPage() : AuthPage();
          }
        },
      ),
    );
  }
}
