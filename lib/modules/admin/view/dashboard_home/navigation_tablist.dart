import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logitrack/modules/admin/view/dashboard_home/add_company.dart';
import 'package:logitrack/modules/company/utils/colors.dart';

import '../../../../utils/responsivesize.dart';

class NavigationTab extends StatefulWidget {
  final Function(String) onItemSelected;

  const NavigationTab({Key? key, required this.onItemSelected})
      : super(key: key);

  @override
  State<NavigationTab> createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  int _selectedIndex = 0;
  bool _selectedIndex1 = false;
  int colorSelection = 0;

  void indexChanged(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.W(context) * .150,
      height: Helper.H(context),
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Logitrack',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Helper.W(context) * .020),
            ),
            SizedBox(
              height: Helper.H(context) * .050,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCompany(),
                    ));
              },
              child: Container(
                width: Helper.W(context) * .110,
                height: Helper.H(context) * .050,
                decoration: BoxDecoration(
                  color: ColorsClass.blueshade,
                  borderRadius: BorderRadius.circular(Helper.W(context) * .030),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.add),
                    Text('Add Company'),
                  ],
                ),
              ),
            ),
            ListTile(
              // tileColor: _selectedIndex == 0 ? Colors.amber : null,
              leading: const Icon(Icons.desktop_mac_outlined),
              title: Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight:
                      _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                  // color: _selectedIndex == 0 ? Colors.amber : Colors.white
                ),
              ),
              onTap: () {
                print(_selectedIndex);
                indexChanged(0);
                setState(() {
                  _selectedIndex1 = true;
                });
                widget.onItemSelected('Dashboard');
              },
            ),
            buildListTileTitle("Company", 2, Icons.remove_red_eye),
            buildListTileTitle("Delivery Boys", 3, Icons.person),
            buildListTileTitle("Notification", 4, Icons.notifications_active),
            buildListTileTitle("user", 4, Icons.person),
            SizedBox(height: Helper.H(context) * .300),
            buildListTileTitle("About us", 5, Icons.question_mark),
            buildListTileTitle("Log out", 6, Icons.logout),
          ],
        ),
      ),
    );
  }

  ListTile buildListTileTitle(
    String Head,
    int index,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 16,
      ),
      textColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 15),
      selected: _selectedIndex == index,
      // selectedColor: _selectedIndex == index ? Colors.amber : Colors.white,
      // iconColor: _selectedIndex == index ? Colors.amber : Colors.white,
      title: Text(
        '$Head',
        style: TextStyle(
            fontWeight:
                _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
            fontSize: 12),
      ),
      onTap: () {
        print(_selectedIndex);

        indexChanged(index);
        widget.onItemSelected(
          '$Head',
        );
      },
    );
  }

  ListTile buildListTile(String Field, int Index) {
    return ListTile(
      selectedColor: _selectedIndex == Index ? Colors.amber : Colors.white,
      iconColor: _selectedIndex == Index ? Colors.amber : Colors.white,
      selected: _selectedIndex == Index,
      title: Text(
        '$Field',
        style: TextStyle(
            color: _selectedIndex == Index ? Color(0xFFD89C3C) : Colors.white,
            fontSize: 12),
      ),
      onTap: () {
        print(_selectedIndex);

        indexChanged(Index);
        widget.onItemSelected("$Field");
      },
    );
  }
}
