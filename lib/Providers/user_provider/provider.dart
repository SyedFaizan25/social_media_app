import 'package:flutter/material.dart';
import 'package:social_media_app/Models/UsersModel.dart';
import 'package:social_media_app/View_Model/UserViewModel.dart';

class UserProvider extends ChangeNotifier {

  List<UserModel>? _userModel;
  List<UserModel>? get userModel => _userModel;

  final userViewModel=UserViewModel();

  Future<List<UserModel>> getUsers(context) async{
    _userModel= await userViewModel.getUsers(context);
    notifyListeners();
    debugPrint("Yes");
    debugPrint(_userModel!.length.toString());
    return _userModel!;

}

}
