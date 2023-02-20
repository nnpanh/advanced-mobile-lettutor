import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/screens/login_page.dart';
import 'package:lettutor/utils.dart';
import 'package:lettutor/const/image_path.dart';
import 'package:page_transition/page_transition.dart';

import 'config/router.dart';
import 'const/themes.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.blue),
    );

    WidgetsFlutterBinding.ensureInitialized();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LetTutor',
        theme: ThemeData.from(colorScheme: lightTheme()),
        darkTheme: ThemeData.from(colorScheme: darkTheme()),
        themeMode: getDeviceThemeMode(),
        onGenerateRoute: MyRouter.generateRoute,
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: const Image(image: AssetImage(ImagesPath.logo)),
            nextScreen: const LoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.bottomToTop,
            backgroundColor: Colors.white)
        // initialRoute: MyRouter.splash,
        );
  }
}
