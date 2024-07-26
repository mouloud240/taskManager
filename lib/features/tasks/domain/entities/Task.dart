// ignore_for_file: file_names
class Task {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });
  String getType() {
    return "";
  }
}
