class ToDoModel {
  final String id;
  final String text;
  final DateTime createdAt;

  final String userID;
  final String userName;
  final String userImageURL;

  ToDoModel({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userID,
    required this.userName,
    required this.userImageURL,
  });
}
