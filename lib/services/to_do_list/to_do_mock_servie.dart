import 'dart:async';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/to_do_list/to_do_service.dart';
import 'dart:math';

class ToDoMockService implements ToDoService {
  static final List<ToDoModel> _listToDo = [
    ToDoModel(
      id: '1',
      text: 'terminar um trabalho',
      createdAt: DateTime.now(),
      userID: '123',
      userName: 'renato',
      userImageURL: 'assets/images/avatar.png',
    ),
    ToDoModel(
      id: '13',
      text: 'terminar um app',
      createdAt: DateTime.now(),
      userID: '321',
      userName: 'samanta',
      userImageURL: 'assets/images/avatar.png',
    ),
    ToDoModel(
      id: '12',
      text: 'terminar uma tarefa de casa',
      createdAt: DateTime.now(),
      userID: '456',
      userName: 'samuel',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];

  static MultiStreamController<List<ToDoModel>>? _controller;
  static final _streamListToDo = Stream<List<ToDoModel>>.multi((controller) {
    _controller = controller;
    controller.add(_listToDo);
  });

  @override
  Stream<List<ToDoModel>> streamToDoItens() {
    return _streamListToDo;
  }

  @override
  Future<ToDoModel> save(String text, LogUser user) async {
    final newToDo = ToDoModel(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userID: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _listToDo.add(newToDo);
    _controller?.add(_listToDo.reversed.toList());
    return newToDo;
  }
}
