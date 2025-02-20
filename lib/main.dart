import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/items_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemsProvider(),
      child: MaterialApp(
        title: 'Expyr App (Assignment 1)',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const DashboardScreen(),
      ),
    );
  }
} 