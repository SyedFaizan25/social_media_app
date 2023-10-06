import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app/Providers/photo/provider.dart';
import 'package:social_media_app/Providers/user_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/View/bottomBar.dart';

import 'Providers/bottom_navigation_bar/provider.dart';
import 'View/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
          ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ],
        child: MaterialApp(
          title: 'Social Media App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      );
    });
  }
}

