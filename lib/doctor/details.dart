import 'package:flutter/material.dart';

class FlaggedDetails extends StatelessWidget {
  const FlaggedDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Text('Random Text Until API integration'),
      ),
    );
  }
}
