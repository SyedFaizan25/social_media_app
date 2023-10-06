import 'package:flutter/material.dart';
import 'package:social_media_app/Models/PhotoModel.dart';
import 'package:social_media_app/View_Model/PhotoViewModel.dart';

class PhotoProvider extends ChangeNotifier {
  List<PhotoModel>? _photoModel;
  List<PhotoModel>? get photoModel => _photoModel;

  final photoViewModel=PhotoViewModel();

  Future<List<PhotoModel>> getPhotos(context) async{
    _photoModel= await photoViewModel.getPhotos(context);
    notifyListeners();
    debugPrint("Yes");
    debugPrint(_photoModel!.length.toString());
    return _photoModel!;

  }
}
