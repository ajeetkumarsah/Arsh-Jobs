import 'package:cariera/bindings/bindings.dart';
import 'package:cariera/controller/app_controller.dart';
import 'package:cariera/firebase_options.dart';
import 'package:cariera/services/firebase_api.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_translator/google_translator.dart';
import 'utils/methods.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await dependencies();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetBuilder<AppController>(
      init: AppController(sharedPreferences: Get.find()),
      builder: (ctlr) {
        return GoogleTranslatorInit(
          AppConstants.googleApiKey,
          translateFrom: const Locale('en'),
          translateTo: ctlr.locale,
          builder: () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Arsh Jobs',
            locale: ctlr.locale,
            fallbackLocale: const Locale('en', 'US'),
            theme: ThemeData(
              fontFamily: 'mplus',
              primarySwatch: Colors.blue,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(bodyColor: dark),
            ),
            home: const SplashView(),
            builder: EasyLoading.init(),
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }
}
