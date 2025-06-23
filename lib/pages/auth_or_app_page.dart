import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/pages/auth_page.dart';
import 'package:to_do_list/pages/loading_page.dart';
import 'package:to_do_list/pages/to_do_list_page.dart';
import 'package:to_do_list/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  } 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingPage();
          }else {
      return StreamBuilder(
        stream: AuthService().userChanges, 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingPage();
          }else{
            return snapshot.hasData ? ToDoListPage() : AuthPage();
            }
          },
        );
      }
    } 
   ); 
  }
}
