import 'package:flutter/material.dart';
import 'package:grad_app/doctor/request_details.dart';

import '../components/flagged_item.dart';

class Viewed extends StatelessWidget {
  const Viewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          FlaggedItem(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RequestDetails();
                }));
              },
              patientName: 'Patient Name',
              mriImage:
                  "https://static.sciencelearn.org.nz/images/images/000/001/104/embed/75yo_male.jpg"),
        ],
      ),
    );
  }
}
