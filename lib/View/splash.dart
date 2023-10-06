import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:social_media_app/View/bottomBar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 60.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("Images/splashImage.jpeg")
                    )
                ),

                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 40.w, vertical: 9.h),
                  child:  Text(
                    'Instravel',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Share your happiness',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 30),
                  ),
                  const Text(
                    'around the World',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 30),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const Text(
                      'Explore the world and share your trip into instravel and bring your happiness together',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 6.h,
                    width: 90.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const BottomNavigationBarScreen()));
                        },
                        child: const Text("Get Started",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



