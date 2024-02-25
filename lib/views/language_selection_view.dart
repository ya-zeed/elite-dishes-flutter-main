// ignore_for_file: must_be_immutable

import 'package:elite/appresources/app_colors.dart';
import 'package:elite/modals/recipe_language_response.dart';
import 'package:elite/views/descriptiom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectionView extends StatefulWidget {
  LanguageSelectionView({required this.arguments});
  List arguments = [];

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  RecipeLanguageResponse? langRes;
  int? id;

  @override
  void initState() {
    langRes = widget.arguments[1];
    id = int.parse(
      widget.arguments[0],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose language"),
      ),
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DescriptionView(args: [
                          id,
                          langRes!.data![index],
                        ]);
                      },
                    ),
                  );
                },
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20.r,
                ),
                title: Text("${langRes!.data![index].language}"),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 0,
              );
            },
            itemCount: langRes!.data!.length,
          ),
        ],
      ),
    );
  }
}
