import 'package:flutter/material.dart';
import 'package:logitrack/modules/user/screens/pages/bottom_bar.dart';

class OrderConformed extends StatefulWidget {
  const OrderConformed({super.key});

  @override
  State<OrderConformed> createState() => _OrderConformedState();
}

class _OrderConformedState extends State<OrderConformed> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomnavUser(
              selectedindex: 0,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text('Your order cornformed \n\n thanks for choosing '),
        ),
      ),
    );
  }
}
