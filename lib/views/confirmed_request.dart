import 'package:flutter/material.dart';

class ConfirmedRequestsScreen extends StatelessWidget {
  const ConfirmedRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: const Text(
          'You don\'t have any confirmed requests yet!',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
