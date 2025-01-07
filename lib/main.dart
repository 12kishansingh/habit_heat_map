import 'package:flutter/material.dart';
import 'package:habit_heat_map/darkmode.dart';
import 'package:habit_heat_map/home_page.dart';
import 'package:habit_heat_map/lightmode.dart';
import 'package:habit_heat_map/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
