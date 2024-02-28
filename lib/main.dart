import 'package:elite/appresources/app_colors.dart';
import 'package:elite/views/onboarding_view.dart';
import 'package:elite/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;

void main() async {
  await _initHive();

  runApp(const MyApp());
}

_initHive() async {
  await Hive.initFlutter();
  box = await Hive.openBox('hourhub');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimaryColor),
          useMaterial3: true,
          fontFamily: 'Cairo',
        ),
        home: box.get('onboarding_completed', defaultValue: false) ? OnboardingView() : OnboardingView(),
      ),
    );
  }
}
