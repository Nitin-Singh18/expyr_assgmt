import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/utils.dart';
import 'providers/items_provider.dart';
import 'screens/dashboard_screen.dart';
import 'services/mock_firestore_service.dart';
import 'theme/app_theme.dart';

/// Global navigator key for accessing navigation outside the widget tree.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() {
    runApp(
      ChangeNotifierProvider(
        create: (context) =>
            ItemsProvider(databaseService: MockFirestoreService())
              ..fetchItems(),
        child: const MyApp(),
      ),
    );
  }, (e, s) {
    debugPrint("Global Error Handler Caught: ${e.toString()}");

    // Displays a bottom sheet for unhandled errors.
    if (navigatorKey.currentContext != null) {
      showErrorBottomSheet(context: navigatorKey.currentContext!, exception: e);
    }
  });
}

/// Root widget of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _lastShownError;

  @override
  Widget build(BuildContext context) {
    final error =
        context.select<ItemsProvider, String?>((provider) => provider.error);

    if (error != null && error != _lastShownError) {
      _lastShownError =
          error; // Store the last shown error to prevent repetition

      WidgetsBinding.instance.addPostFrameCallback((_) {
        debugPrint("Error Handler Caught: $error");

        showErrorBottomSheet(
          context: navigatorKey.currentContext!,
          exception: error,
        );
      });
    }

    return MaterialApp(
      title: 'Expyr App (Assignment 1)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: navigatorKey,
      home: const DashboardScreen(),
    );
  }
}
