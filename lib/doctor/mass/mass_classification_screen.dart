import 'package:flutter/material.dart';

import 'grid.dart';

class MassClassificationScreen extends StatelessWidget {
  final String userToken;
  const MassClassificationScreen({Key? key, required this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff392850),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            GridDashboard(userToken: userToken,),
          ],
        ),
      ),
    );
  }
}
