import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/screens/authentication/login_page.dart';
import 'package:lettutor/utils/utils.dart';
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LetTutor',
          theme: ThemeData(fontFamily: 'Roboto', colorScheme: lightTheme()),
          darkTheme: ThemeData(fontFamily: 'Roboto', colorScheme: darkTheme()),
          themeMode: getDeviceThemeMode(),
          onGenerateRoute: MyRouter.generateRoute,
          home: AnimatedSplashScreen(
              duration: 2000,
              splash: const Image(image: AssetImage(ImagesPath.logo)),
              nextScreen: const LoginPage(),
              // nextScreen: const LoginPage(),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
              backgroundColor: Colors.white)
          // initialRoute: MyRouter.splash,
          ),
    );
  }
}
