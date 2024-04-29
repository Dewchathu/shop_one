import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_one/firebase_options.dart';
import 'package:shop_one/routes.dart';
import 'package:shop_one/screens/splash/splash_screen.dart';
import 'package:shop_one/theme.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop One',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}