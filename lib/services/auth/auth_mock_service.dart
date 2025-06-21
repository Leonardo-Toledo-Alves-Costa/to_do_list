import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final _defaultUser = LogUser(
    id: '1',
    name: 'default',
    email: 'default@gmail.com',
    imageURL: 'assets/images/avatar.png',
  );

  static final Map<String, LogUser> _users = {
    _defaultUser.email: _defaultUser,
    };

  static LogUser? _currentUser;
  static MultiStreamController<LogUser?>? _controller;
  static final _userStream = Stream<LogUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  LogUser get currentUser {
    return _currentUser!;
  }

  @override
  Stream<LogUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = LogUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(LogUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
