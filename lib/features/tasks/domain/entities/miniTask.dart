class Minitask {
  String name;
  bool status;
  Minitask({required this.name, this.status = false});

  factory Minitask.fromJson(Map<String, dynamic> json) {
    return Minitask(name: json["name"], status: json['status']);
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "status": status};
  }
}
