import 'package:social_media_app/Models/UsersModel.dart';
import 'package:social_media_app/Repositories/UserRepo.dart';



class UserViewModel{

final _userApiRepo=UserRepo();

Future<List<UserModel>> getUsers(context)async{

 return await _userApiRepo.getUsers(context);
}

}