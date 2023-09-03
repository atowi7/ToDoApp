class TaskModel {
  final int id;
  final String title;
  // final String note;
  final bool isDone;
  final String createdAt;
  final int categoryId;

  TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
    required this.categoryId,
  });
}
