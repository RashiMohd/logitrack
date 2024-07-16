import 'package:flutter/material.dart';
import 'package:logitrack/modules/user/screens/pages/home_page.dart';
import 'package:logitrack/modules/user/screens/pages/order.dart';
import 'package:logitrack/modules/user/screens/pages/profile.dart';
import 'package:logitrack/modules/user/screens/pages/track_order.dart';
import 'package:logitrack/services/controller.dart';
import 'package:provider/provider.dart';

class BottomnavUser extends StatefulWidget {
  int selectedindex = 0;
  BottomnavUser({super.key, required this.selectedindex});

  @override
  State<BottomnavUser> createState() => _BottomnavUserState();
}

class _BottomnavUserState extends State<BottomnavUser> {
  List<Widget> _pages() {
    return [
      Homepage(),
      TrackOrderScreen(),
      OrderStatus(),
      Profile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, controller, _) {
        return Scaffold(
          body: _pages()[controller.selectedindex],
          bottomNavigationBar: mynav(
            index: controller.selectedindex,
            onTap: (value) {
              controller.changeIndex(value);
              // setState(() {
              //   widget.selectedindex = index;
              // });
            },
          ),
        );
      },
    );
  }
}

Widget mynav({
  int? index,
  void Function(int)? onTap,
}) {
  return NavigationBar(
    selectedIndex: index!,
    onDestinationSelected: onTap,
    indicatorColor: Colors.blue,
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
        icon: Image.asset('assets/images/Truck.png'),
        label: 'Track',
      ),
      NavigationDestination(
        icon: Image.asset('assets/images/profile.png'),
        label: 'Profile',
      ),
    ],
  );
}
