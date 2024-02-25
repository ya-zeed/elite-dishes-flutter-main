// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elite/networking/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum RequestMethod { POST, GET, PUT, PATCH, DELETE }

class ApiServices {
  static Future<dynamic> request(String path, {required RequestMethod method, data, queryParameters}) async {
    try {
      ApiConfig().dio.options.method = describeEnum(method);
      Response response = await ApiConfig().dio.request(path, data: data, queryParameters: queryParameters);
      log(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      }
    } on DioError catch (e) {
      log("${e.response}");
      // Fluttertoast.showToast(msg: "Something went wromg");
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No internet connection");
    }
  }
}
