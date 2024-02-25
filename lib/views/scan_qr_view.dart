// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:elite/appresources/app_colors.dart';
import 'package:elite/appresources/constant.dart';
import 'package:elite/modals/recipe_language_response.dart';
import 'package:elite/networking/api_paths.dart';
import 'package:elite/networking/api_services.dart';
import 'package:elite/views/descriptiom_view.dart';
import 'package:elite/views/language_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrView extends StatefulWidget {
  ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;
  bool isLoading = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        isLoading = true;
        result = scanData;
        callApi();
      });
    });
  }

  void callApi() async {
    if (result != null) {
      await controller!.pauseCamera();
      var response = await ApiServices.request(ApiPaths.getRecipe(result!.code.toString()), method: RequestMethod.GET);
      if (response != null) {
        RecipeLanguageResponse? recipeLanguageResponse = RecipeLanguageResponse.fromJson(response);
        if (recipeLanguageResponse.data!.isNotEmpty) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LanguageSelectionView(arguments: [
                  result!.code,
                  recipeLanguageResponse,
                ],);
              },
            ),
          ).then(
            (value) async {
              return await controller!.resumeCamera();
            },
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return DescriptionView(args: [
          //         result!.code,
          //         recipeLanguageResponse,
          //       ]);
          //     },
          //   ),
          // ).then(
          //   (value) async {
          //     return await controller!.resumeCamera();
          //   },
          // );
        } else {
          await controller!.resumeCamera();
          Fluttertoast.showToast(msg: "Invalid Qr Code");
        }
      } else {
        await controller!.resumeCamera();
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Invalid Qr Code");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 30.h,
              // ),
              // Text(
              //   "مسح رمز الاستجابة السريعة",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w700,
              //     fontSize: 26.sp,
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "ضع رمز الاستجابة السريعة داخل الإطار لمسحه ضوئيًا. يرجى تجنب الاهتزاز للحصول على النتيجة بسرعة",
              //   softWrap: true,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 16.sp,
              //   ),
              // ),
              LottieBuilder.asset(
                Constants.descriptionAnim,
                fit: BoxFit.cover,
                height: 250.h,
                width: 250.h,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "امسحي الباركود",
                  style: TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "\nواختاري",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "\nاللغة المناسبة لخادمتك",
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
                height: 30.h,
              ),
              Container(
                height: 250.h,
                width: 250.h,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              isLoading ? CircularProgressIndicator() : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller!.toggleFlash();
        },
        child: Icon(
          Icons.light_mode_outlined,
        ),
      ),
    );
  }
}
