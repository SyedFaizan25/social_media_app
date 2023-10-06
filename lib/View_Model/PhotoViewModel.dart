import 'package:social_media_app/Models/PhotoModel.dart';

import '../Repositories/PhotoRepo.dart';

class PhotoViewModel{

  final _photoRepo=PhotoRepo();

  Future<List<PhotoModel>> getPhotos(context)async{

    return await _photoRepo.getPhotos(context);
  }

}