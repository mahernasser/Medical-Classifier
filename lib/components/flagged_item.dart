import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../resources/app_colors.dart';

class FlaggedItem extends StatelessWidget {
  final String patientName;
  final String mriImage;
  final onTap;
  const FlaggedItem({
    super.key,
    required this.patientName,
    required this.mriImage,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 10,
          child: Container(
            alignment: Alignment.bottomLeft,
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    stops: const [0.4, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.8),
                    ]),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(mriImage),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.kSecondryColor.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Text(
                        patientName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
