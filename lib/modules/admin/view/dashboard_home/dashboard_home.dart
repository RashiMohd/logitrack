 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logitrack/modules/admin/view/dashboard_home/screen_selection.dart';
 
 
import 'navigation_tablist.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  String _selectedItem = "Dashboard";

  void _setSelectednavItem(String item) {
    setState(() {
      _selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationTab(
              onItemSelected: _setSelectednavItem,
            ),
            Expanded(
              flex: 5,
              child: ScreenSelection(selectedNavItem: _selectedItem),
            ),
          ],
        ),
      ),
    );
  }
}
