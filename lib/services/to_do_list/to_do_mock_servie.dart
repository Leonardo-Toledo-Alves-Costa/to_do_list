import 'dart:async';
import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/to_do_list/to_do_service.dart';

class ToDoMockService implements ToDoService {
  static final List<ToDoModel> _listToDo = [
    ToDoModel(
      id: '1',
      title: 'Terminar um trabalho',
      text: 'Trabalho de matemática para o dia 12',
      createdAt: DateTime.now(),
      userID: '123',
      userName: 'renato',
      userImageURL: 'assets/images/avatar.png',
    ),
    ToDoModel(
      id: '13',
      title: 'App para a Asimov',
      text: 'terminar um app',
      createdAt: DateTime.now(),
      userID: '321',
      userName: 'samanta',
      userImageURL: 'assets/images/avatar.png',
    ),
    ToDoModel(
      id: '12',
      title: 'Terminar tarefas de casa',
      text: 'lavar a louça',
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
  Future<ToDoModel> save(ToDoModel item, LogUser user) async {
    final newToDo = ToDoModel(
      id: item.id,
      title: item.title,
      text: item.text,
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
