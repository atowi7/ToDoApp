import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/constants/theme.dart';
import 'package:todo_app/provider/localization_provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/view/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/view/screen/onboarding_screen.dart';

import 'generated/l10n.dart';

// late SharedPreferences prefs;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LocalizationProvider>(
        create: (context) => LocalizationProvider()),
    ChangeNotifierProvider<TasksProvider>(create: (context) => TasksProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localizationProvider = Provider.of<LocalizationProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'ToDoApp',
      theme: englishTheme,
      home: const HomeScreen(),
      // prefs.getString('start') == 'skip'
      //     ? const HomeScreen()
      //     : const OnboardingScreen(),
      builder: EasyLoading.init(),
      routes: routes,
      locale: localizationProvider.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
