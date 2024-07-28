// ignore_for_file: file_names
class Task {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String id;
  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.id
  });
  String getType() {
    return "";
  }
}
