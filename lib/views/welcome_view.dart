import 'package:elite/appresources/app_colors.dart';
import 'package:elite/appresources/constant.dart';
import 'package:elite/views/onboarding_view.dart';
import 'package:elite/views/scan_qr_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    Constants.welcomeAnim,
                    fit: BoxFit.cover,
                    height: 300.h,
                    width: 300.h,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "طبختك بيد اللي",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(text: " "),
                        TextSpan(
                          text: "يسنعها",
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(45.r, 50.r),
                      backgroundColor: AppColors.kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ScanQrView();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "ابدأ رحلتك",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnboardingView();
                      },
                    ),
                  );
                },
                label: Icon(
                  Icons.help_outline,
                  color: AppColors.kPrimaryColor,
                  size: 20,
                ),
                icon: Text(
                  "كيفية الاستخدام؟",
                  style: TextStyle(
                    // fontSize: 20.sp,
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
