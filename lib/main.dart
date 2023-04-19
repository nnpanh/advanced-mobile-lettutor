import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/providers/settings_provider.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:lettutor/view/authentication/login_page.dart';
import 'package:lettutor/view/common_widgets/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'config/router.dart';
import 'const/themes.dart';
import 'firebase_options.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();

  static Future<void> initSystemDefault() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.blue),
    );
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

class MyAppState extends State<MyApp> {
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
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SettingsProvider(),
          ),
        ],
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LetTutor',
            theme: ThemeData(fontFamily: 'Roboto', colorScheme: lightTheme()),
            darkTheme:
                ThemeData(fontFamily: 'Roboto', colorScheme: darkTheme()),
            themeMode: getDeviceThemeMode(),
            onGenerateRoute: MyRouter.generateRoute,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Provider.of<SettingsProvider>(context).locale,
            home: LoadingOverlay(
              child: AnimatedSplashScreen(
                  duration: 2000,
                  splash: const Image(image: AssetImage(ImagesPath.logo)),
                  nextScreen: LoadingOverlay(child: const LoginPage()),
                  // nextScreen: const LoginPage(),
                  splashTransition: SplashTransition.fadeTransition,
                  pageTransitionType: PageTransitionType.bottomToTop,
                  backgroundColor: Colors.white),
            )
            // initialRoute: MyRouter.splash,
            ),
      ),
    );
  }
}
