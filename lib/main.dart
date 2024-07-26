import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/features/auth/data/models/usermodel.dart';
import 'package:task_manager/features/auth/presentation/screens/Welcomepage.dart';
import 'package:task_manager/features/auth/presentation/screens/authpages/Signup.dart';
import 'package:task_manager/features/auth/presentation/screens/authpages/loginpage.dart';
import 'package:task_manager/features/auth/presentation/screens/introductionScreens/get_started.dart';
import 'package:task_manager/features/tasks/presentation/screens/homepage.dart';
import 'package:task_manager/firebase_options.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Sofia Pro"),
        routes: {
          'home': (context) => Homepage(),
          "login": (context) => LoginPage(),
          "signUp": (context) => SignupPage(),
        },
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Homepage();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Welcomepage();
              }
            }));
  }
}
