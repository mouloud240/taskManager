// ignore_for_file: file_names
class Task {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String id;
  bool status;
  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.status
  });
  String getType() {
    return "";
  }
}
