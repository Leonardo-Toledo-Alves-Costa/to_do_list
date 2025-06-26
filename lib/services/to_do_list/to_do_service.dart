import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/to_do_list/to_do_firebase_service.dart';

abstract class ToDoService {
  Stream<List<ToDoModel>> streamToDoItens();
  Future<ToDoModel?> save(ToDoModel itemToDo, LogUser user);

  factory ToDoService() {
    return ToDoFirebaseService();
  }
}