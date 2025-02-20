import 'package:flutter/material.dart';

import '../common/extensions/context_extension.dart';
import '../theme/app_color.dart';
import 'available_items_screen.dart';
import 'consumed_items_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Expyr",
          style: context.textTheme.titleLarge?.copyWith(color: AppColor.green),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            AvailableItemsScreen(),
            ConsumedItemsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: "Available",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Consumed",
          ),
        ],
      ),
    );
  }
}
