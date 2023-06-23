import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_app/resources/app_images.dart';

import '../image_picker/image_picker_doctor.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = Items(title: "General", img: AppImages.general);

  Items item2 = Items(
    title: "Mri",
    img: AppImages.mriIcon,
  );

  Items item3 = Items(
    title: "Knee",
    img: AppImages.knee,
  );
  Items item4 = Items(
    title: "Segmentation",
    img: AppImages.segmentation,
  );
  Items item5 = Items(
    title: "Detection",
    img: AppImages.detectObject,
  );
  Items item6 = Items(
    title: "X-Ray",
    img: AppImages.xRay,
  );

  GridDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorImagePickerScreen(data.title);
                }));
              },
              child: Card(
                color: Color(color),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 72,
                        color: Colors.white,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;

  String img;

  Items({required this.title, required this.img});
}
