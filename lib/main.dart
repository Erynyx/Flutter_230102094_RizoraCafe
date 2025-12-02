import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/cart_controller.dart';
import 'themes/app_theme.dart';
import 'pages/main_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cafe App",
      theme: AppThemes.lightTheme,
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
