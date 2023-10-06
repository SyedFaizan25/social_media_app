import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/View/favourite.dart';
import 'package:social_media_app/View/personal.dart';
import 'package:social_media_app/View/posts.dart';

import '../Providers/bottom_navigation_bar/provider.dart';
class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List<Widget> listWidget=[
    const PostScreen(),
    const FavouriteScreen(),
    const PersonalAccountScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body:Consumer<BottomNavigationBarProvider>(
      builder: (context, bottomNavigationBarProvider, child){
      return listWidget[bottomNavigationBarProvider.currentIndex];
    }
    ),

      bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
        builder: (context, bottomNavigationBarProvider, child){
      return BottomNavigationBar(
        selectedItemColor: Colors.lightBlueAccent,
        currentIndex: bottomNavigationBarProvider.currentIndex,
        onTap: (index){
          bottomNavigationBarProvider.setIndex(index);
          if(index==0){

          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,),label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: '')
        ],
      );
    }
    ),
    );
  }
}
