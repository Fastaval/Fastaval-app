import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'modules/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

/*   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); */

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('da'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('da'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => tr('app.title'),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomePageView(),
    );
  }
}
