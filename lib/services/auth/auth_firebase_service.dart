import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/services/auth/auth_service.dart';

class AuthFirebaseService implements AuthService {
  static LogUser? _currentUser;
  static final _userStream = Stream<LogUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toLogUser(user);
      controller.add(_currentUser);
    }
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
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) return;

    final imageName = '${credential.user!.uid}.jpg';
    final imageURL = await _uploadUserImage(image, imageName);

    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageURL);

    await _saveLogUser(_toLogUser(credential.user!, imageURL));
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?>? _uploadUserImage (File? image, String imageName) async {
    if(image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveLogUser(LogUser user) async{
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

     return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL
    });
  }

  static LogUser _toLogUser(User user, [String? imageURL]) {
    return LogUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
