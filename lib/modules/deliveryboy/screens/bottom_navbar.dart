import 'package:flutter/material.dart';
import 'package:logitrack/modules/company/screens/pages/routes/track.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/home_page.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/notiication.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/order.dart';
import 'package:logitrack/modules/deliveryboy/screens/pages/profile.dart';
import 'package:logitrack/modules/user/screens/pages/home_page.dart';
import 'package:logitrack/modules/user/screens/pages/order.dart';
import 'package:logitrack/modules/user/screens/pages/profile.dart';
import 'package:logitrack/modules/user/screens/pages/track_order.dart';

class BottomnavDelivery extends StatefulWidget {
  int selectedindex = 0;
  BottomnavDelivery({super.key, required this.selectedindex});

  @override
  State<BottomnavDelivery> createState() => _BottomnavDeliveryState();
}

class _BottomnavDeliveryState extends State<BottomnavDelivery> {
  @override
  Widget build(BuildContext context) {
    final _pages = [
      HomepageDelivery(),
      Orderbottomdelivery(),
      DEliveryTrck(),
      Profiledelivery(),
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
      NavigationDestination(
        icon: Image.asset('assets/imagesdelivery/Alarm.png'),
        label: 'Track',
      ),
      NavigationDestination(
        icon: Image.asset('assets/images/profile.png'),
        label: 'Profile',
      ),
    ],
  );
}
