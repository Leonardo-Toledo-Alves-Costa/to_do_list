import 'package:flutter/material.dart';
import 'package:to_do_list/components/auth_form.dart';
import 'package:to_do_list/models/auth_form_data.dart';
import 'package:to_do_list/services/auth/auth_mock_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async{
    try{
    setState(()=> _isLoading = true);

    if (formData.isLogin){
      await AuthMockService().login(
      formData.email, 
      formData.password,
      );

    }else {
      await AuthMockService().signUp(
      formData.name, 
      formData.email, 
      formData.password, 
      formData.image);
    }
    }catch(error){

    }finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Center(
        child: SingleChildScrollView(
          child: AuthForm(onSubmit: _handleSubmit,)
            )
          ),
          if(_isLoading)
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.5)
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      )
    );
  }
}