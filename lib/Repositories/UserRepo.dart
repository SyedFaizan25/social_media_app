import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/Models/UsersModel.dart';

import '../Constant/BaseUrl.dart';

class UserRepo {
  Future<List<UserModel>> getUsers(context) async {
    String url = "${BaseUrl.baseUrl}users";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<UserModel> userModel = List<UserModel>.from(
            l.map((model) => UserModel.fromJson(model)));
        return userModel;
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
