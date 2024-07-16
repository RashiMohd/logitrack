import 'package:flutter/material.dart';
import 'package:logitrack/modules/company/screens/home/home_page.dart';
import 'package:logitrack/modules/company/screens/pages/notiication.dart';
import 'package:logitrack/modules/company/screens/pages/order.dart';
import 'package:logitrack/modules/company/screens/pages/profile.dart';
import 'package:logitrack/modules/company/screens/pages/routes/home/tracking.dart';

class BottomnavCompany extends StatefulWidget {
  int selectedindex = 0;
  BottomnavCompany({super.key, required this.selectedindex});

  @override
  State<BottomnavCompany> createState() => _BottomnavCompanyState();
}

class _BottomnavCompanyState extends State<BottomnavCompany> {
  @override
  Widget build(BuildContext context) {
    final _pages = [
      HomepageCompany(),
      OrderbottomCompany(),
      // CompanyOrder(),s
      Profile(),
    ];

    return Scaffold(
      body: _pages[widget.selectedindex],
      bottomNavigationBar: mynav(
        index: widget.selectedindex,
        onTap: (index) {
          setState(() {
            widget.selectedindex = index;
          });
        },
      ),
    );
  }
}

Widget mynav({int? index, void Function(int)? onTap, selectedcolor}) {
  return NavigationBar(
    selectedIndex: index!,
    onDestinationSelected: onTap,
    destinations: [
      NavigationDestination(
        icon: Image.asset(
          'assets/images/Home.png',
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Image.asset('assets/images/order.png'),
        label: 'Order',
      ),
      // NavigationDestination(
      //   icon: Image.asset('assets/imagesdelivery/Alarm.png'),
      //   label: 'Track',
      // ),
      NavigationDestination(
        icon: Image.asset('assets/images/profile.png'),
        label: 'Profile',
      ),
    ],
  );
}
