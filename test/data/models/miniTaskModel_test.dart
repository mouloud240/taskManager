import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';

void main() {
  // Create a test instance of Minitaskmodel
  Minitaskmodel miniTaskModeltest = Minitaskmodel(
    name: "Creating a noteApp",
    status: true,
    id: "0",
  );

  // Test to check the fromJson method
  test("Should return a MiniTaskModel from Json", () async {
    // Arrange: create a JSON map with the expected structure and data
    final Map<String, dynamic> jsonMap = {
      "name": "Creating a noteApp",
      "status": true,
      "id": "0",
    };

    // Act: deserialize the JSON map into a Minitaskmodel instance
    final result = Minitaskmodel.fromJson(jsonMap);

    // Assert: check that the result matches the expected model instance
    expect(result, miniTaskModeltest);
  });
}
