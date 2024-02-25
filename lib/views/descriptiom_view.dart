// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:elite/modals/description_response_modal.dart';
import 'package:elite/modals/recipe_language_response.dart';
import 'package:elite/networking/api_paths.dart';
import 'package:elite/networking/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionView extends StatefulWidget {
  DescriptionView({super.key, required this.args});
  List args = [];

  @override
  State<DescriptionView> createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  // Data? dropdownValue;
  Data? data;
  // RecipeLanguageResponse? langRes;
  int? id;
  DescriptionResponse? descriptionResponse;
  bool isLoading = false;
  // final GlobalKey _dropdownMenuKey = GlobalKey();
  TextEditingController appField = TextEditingController();

  @override
  void initState() {
    data = widget.args[1];
    id = widget.args[0];
    // dropdownValue = langRes!.data![0];
    // appField.text = dropdownValue!.language!;
    callDescriptionApi(id!, data!.id!);
    super.initState();
  }

  callDescriptionApi(int id, int langId) async {
    isLoading = true;
    var response = await ApiServices.request(ApiPaths.getDescription(id, langId), method: RequestMethod.GET);
    if (response != null) {
      descriptionResponse = DescriptionResponse.fromJson(response);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.w),
            //   child: TextFormField(
            //     onTap: () {
            //       dynamic state = _dropdownMenuKey.currentState;
            //       state.showButtonMenu();
            //     },
            //     controller: appField,
            //     readOnly: true,
            //     decoration: InputDecoration(
            //       isDense: true,
            //       contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(4.0),
            //         ),
            //       ),
            //       suffixIcon: PopupMenuButton<Data>(
            //         key: _dropdownMenuKey,
            //         icon: const Icon(
            //           Icons.keyboard_arrow_down_outlined,
            //         ),
            //         onSelected: (Data? value) {},
            //         itemBuilder: (BuildContext context) {
            //           return langRes!.data!.map<PopupMenuItem<Data>>((value) {
            //             return PopupMenuItem(
            //               onTap: () {
            //                 appField.text = value.language!;
            //                 dropdownValue = value;
            //                 callDescriptionApi(id!, dropdownValue!.id!);
            //               },
            //               child: SizedBox(
            //                 width: MediaQuery.of(context).size.width,
            //                 child: Text(value.language!),
            //               ),
            //               value: value,
            //             );
            //           }).toList();
            //         },
            //       ),
            //       // suffixIcon: DropdownMenu<Data>(
            //       //   controller: TextEditingController(text: dropdownValue!.language),
            //       //   inputDecorationTheme: const InputDecorationTheme(isDense: true, border: InputBorder.none),
            //       //   onSelected: (Data? value) {
            //       //     setState(() {
            //       //       dropdownValue = value;
            //       //       callDescriptionApi(id!, dropdownValue!.id!);
            //       //     });
            //       //   },
            //       //   dropdownMenuEntries: langRes!.data!.map<DropdownMenuEntry<Data>>(
            //       //     (Data icon) {
            //       //       return DropdownMenuEntry<Data>(
            //       //         value: icon,
            //       //         label: icon.language!,
            //       //       );
            //       //     },
            //       //   ).toList(),
            //       // ),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Html(
                        data: descriptionResponse?.data?.content ?? "",
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
