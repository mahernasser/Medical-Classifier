import 'package:flutter/material.dart';
import 'package:grad_app/doctor/request_details.dart';

import '../components/flagged_item.dart';

class Flagged extends StatelessWidget {
  const Flagged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          FlaggedItem(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RequestDetails();
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
