import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/domain/usecases/getDailyTasksUsecase.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late Getdailytasksusecase getdailytasksusecase;
  late MockTaskmanagementrepository mymockTaskmanagementrepository;
  setUp(() {
    mymockTaskmanagementrepository = MockTaskmanagementrepository();
    getdailytasksusecase = Getdailytasksusecase(mymockTaskmanagementrepository);
  });
  List<Dailtaskmodel> testDailytasks = [
    Dailtaskmodel(
        title: "run",
        description: "I want the test to fail",
        startDate: DateTime.utc(2024, 7, 26, 23, 12, 28),
        endDate: DateTime.utc(2024, 7, 27, 23, 12, 43),
        id: "0",
        )
  ];
  test("Should Get the list of dailyTasks", () async {
    //arrange
    when(mymockTaskmanagementrepository.getDailyTasks())
        .thenAnswer((_) async => Right(testDailytasks));

    //act
    final result = await getdailytasksusecase.call();
    //assert
    expect(result, Right(testDailytasks));
  });
}
