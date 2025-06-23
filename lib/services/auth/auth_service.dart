import 'dart:io';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/services/auth/auth_firebase_service.dart';

abstract class AuthService {
  LogUser get currentUser;

  Stream<LogUser?> get userChanges;

  Future<void> signUp(String nome, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

  factory AuthService(){
    return AuthFirebaseService();
  }
}
