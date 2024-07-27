import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';

void main() {
  Minitaskmodel miniTaskModeltest =
      Minitaskmodel(name: "Creating a noteApp", status: true,id: 0);
  test("Should return a MiniTaskModel from Json", () async {
    //arrange
    final Map<String, dynamic> jsonMap = {
      "name": "Creating a noteApp",
      "status": true,
      "id":0,
    };
    //act
    final result = Minitaskmodel.fromJson(jsonMap);

    //assert
    expect(result, miniTaskModeltest);
  });
}
