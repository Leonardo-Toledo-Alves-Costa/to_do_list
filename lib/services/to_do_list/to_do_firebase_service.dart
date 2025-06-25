import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/to_do_list/to_do_service.dart';

class ToDoFirebaseService implements ToDoService {

  @override
  Stream<List<ToDoModel>> streamToDoItens() {
    return Stream<List<ToDoModel>>.empty();
  }

  @override
  Future<ToDoModel?> save(String text, LogUser user) async {
    final store = FirebaseFirestore.instance;
    store.collection('itens').add({
      'title': text,
      'text': text,
      'createdAt': DateTime.now.toString(),
      'userID': user.id,
      'userName': user.name,
      'userImageURL': user.imageURL,
    });
    return null;
  }
}
