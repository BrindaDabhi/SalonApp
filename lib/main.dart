import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_salon/auth_pages/welcome.dart';
import 'package:my_salon/details/salon_detail.dart';
import 'package:my_salon/drawer_pages/upload_data.dart';
import 'package:my_salon/home_page.dart';
import 'package:my_salon/notifier/sp_notifier.dart';
import 'package:my_salon/notifier/user_notifier.dart';
import 'package:my_salon/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SPNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserNotifier(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
