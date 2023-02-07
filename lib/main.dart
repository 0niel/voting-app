import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart' as serviceLocator;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  serviceLocator.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Система очного голосования',
      theme: AppTheme.theme,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
