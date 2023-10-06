import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/Models/PhotoModel.dart';
import '../Constant/BaseUrl.dart';

class PhotoRepo {
  Future<List<PhotoModel>> getPhotos(context) async {
    String url = "${BaseUrl.baseUrl}photos";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<PhotoModel> photoModel = List<PhotoModel>.from(
            l.map((model) => PhotoModel.fromJson(model)));
        return photoModel;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load Data'),duration: Duration(seconds: 5),));
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()),duration: const Duration(seconds: 5),));
      throw Exception('An error occurred while fetching data');
    }
  }
}
