import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/core/connection/network_info.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/presentation/screens/Welcomepage.dart';
import 'package:task_manager/features/auth/presentation/screens/authpages/Signup.dart';
import 'package:task_manager/features/auth/presentation/screens/authpages/loginpage.dart';
import 'package:task_manager/features/tasks/data/models/DailTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/MiniTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/PriorityTaskModel.dart';
import 'package:task_manager/features/tasks/data/models/colorAdapter.dart';
import 'package:task_manager/features/tasks/domain/entities/dailyTask.dart';
import 'package:task_manager/features/tasks/domain/entities/priorityTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/CreatenewTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/EditDailyTask.dart';
import 'package:task_manager/features/tasks/presentation/screens/PriorityTaskView.dart';
import 'package:task_manager/features/tasks/presentation/screens/homepage.dart';
import 'package:task_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MyColorAdapter());
  Hive.registerAdapter(PrioritytaskmodelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(MinitaskmodelAdapter());
  Hive.registerAdapter(DailtaskmodelAdapter());

  final userBox = await Hive.openBox("User");
  final priotasksBox = await Hive.openBox<Prioritytask>("NewPriorityTasks");
  final dailytasksbox = await Hive.openBox<Dailytask>("MyDailyTasks");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final connectionInfo = NetworkInfoImpl(DataConnectionChecker());
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Sofia pro",
            splashColor: Colors.transparent),
        routes: {
          "login": (context) => const LoginPage(),
          'home': (context) => const Homepage(),
          "signUp": (context) => const SignupPage(),
          "create": (context) => const Createnewtask(),
        },
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return const Homepage();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Welcomepage();
              }
            }));
  }
}
