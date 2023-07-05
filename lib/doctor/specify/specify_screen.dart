import 'package:flutter/material.dart';
import 'package:grad_app/resources/app_images.dart';

class SpecifyClassificationScreen extends StatelessWidget {
  const SpecifyClassificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff453658),
      backgroundColor: const Color(0xff392850),

      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .25,
                decoration: BoxDecoration(
                    color: const Color(0xff453658),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        AppImages.newUser,
                        width: 100,
                        fit: BoxFit.cover,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'New User Classification',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .25,
                decoration: BoxDecoration(
                    color: const Color(0xff453658),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.existingUser,
                      width: 110,
                      fit: BoxFit.cover,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Existing User Classification',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
