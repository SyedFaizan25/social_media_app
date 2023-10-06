import 'package:flutter/material.dart';

import '../../View/posts.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
   int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(index){

    _currentIndex=index;
    notifyListeners();

  }

}
