import 'package:elite/appresources/app_colors.dart';
import 'package:elite/appresources/constant.dart';
import 'package:elite/main.dart';
import 'package:elite/views/welcome_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> onboardingData = [
    {
      'image': Constants.welcomeAnim,
      'title': 'اهلا بك في نخبة الاطباق',
      'subtitle': 'اطلق ابداعك في اعداد الوصفات',
    },
    {
      'image': Constants.qrAnim,
      'title': 'امسح الباركود',
      'subtitle': 'امسح الباركود من الوصفة في كتاب نخبة الاطباق',
    },
    {
      'image': Constants.anim,
      'title': 'اختر اللغة',
      'subtitle': 'اختر الترجمة وابدع في الوصفات',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              // color: Colors.amber,
              // margin: EdgeInsets.only(top: 50),
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    image: onboardingData[index]['image']!,
                    title: onboardingData[index]['title']!,
                    subtitle: onboardingData[index]['subtitle']!,
                    currentPage: _currentPage,
                    onboardingData: onboardingData,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    onboardingData.length,
                    (index) => _buildPageIndicator(index),
                  ),
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
                    if (_currentPage < onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      box.put('onboarding_completed', true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomeView();
                          },
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentPage < onboardingData.length - 1 ? 'التالي' : 'تم',
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      width: _currentPage == index ? 16.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _currentPage == index ? AppColors.kPrimaryColor : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final currentPage;
  final onboardingData;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
    this.currentPage,
    this.onboardingData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: currentPage < onboardingData.length - 1 ? 50 : 0),
              child: Center(
                child: LottieBuilder.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // SizedBox(height: 20.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
