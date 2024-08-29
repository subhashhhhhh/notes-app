class Note {
  String id;
  String title;
  String content;
  bool isArchived;
  bool isDeleted;
  DateTime createdTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.isArchived = false,
    this.isDeleted = false,
    required this.createdTime,
  });
}
