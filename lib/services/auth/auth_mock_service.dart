import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/services/auth/auth_service.dart';

class AuthMockService implements AuthService{
  static final Map<String, LogUser> _users = {};
  static LogUser? _currentUser;
  static MultiStreamController<LogUser?>? _controller;
  static final _userStream = Stream<LogUser?>.multi((controller){
    _controller = controller;
    _updateUser(null);
  });
  
  @override
  LogUser get currentUser{
    return _currentUser!;
  }

  @override
  Stream<LogUser?> get userChanges{
    return _userStream;
  }

  @override
  Future<void> signUp(String name, String email, String password, File image) async{
    final newUser = LogUser(
    id: Random().nextDouble().toString(), 
    name: name, 
    email: email, 
    imageURL: image.path,
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async{
    _updateUser(null);
  }

  static void _updateUser(LogUser? user){
    _currentUser = user;
    _controller?.add(_currentUser);
  }

}