import 'package:to_do_list/models/log_user.dart';
import 'package:to_do_list/models/to_do_model.dart';
import 'package:to_do_list/services/to_do_list/to_do_mock_servie.dart';

abstract class ToDoService {
  Stream<List<ToDoModel>> streamToDoItens();
  Future<ToDoModel> save(String text, LogUser user);

  factory ToDoService() {
    return ToDoMockService();
  }
}