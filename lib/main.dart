import 'package:auth_koko/pages/auth_page.dart';
import 'package:auth_koko/themes/themeMode.dart';
import 'package:auth_koko/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth Koko',
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      home: const AuthPage(),
    );
  }
}
