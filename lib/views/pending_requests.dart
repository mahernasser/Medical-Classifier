import 'package:flutter/material.dart';
import 'package:grad_app/components/mri_item.dart';

class PendingRequestsScreen extends StatelessWidget {
  const PendingRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            MriItem(
                drName: 'Dr Mostafa',
                mriImage:
                    "https://static.sciencelearn.org.nz/images/images/000/001/104/embed/75yo_male.jpg")
          ],
        ),
      ),
    );
  }
}
