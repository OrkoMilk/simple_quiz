import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_quizapp/app.dart';
import 'package:flutter_simple_quizapp/app_config.dart';
import 'package:flutter_simple_quizapp/theme/assets.dart';
import 'package:flutter_simple_quizapp/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';
import 'utils/logger.dart';

const englishLocale = Locale('en', 'US');
const ukrainianLocale = Locale('uk', 'UA');

bool isProduction = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  isProduction = const bool.fromEnvironment('IS_PRODUCTION', defaultValue: false);

  if (isProduction) {
    EasyLocalization.logger.enableBuildModes = [];
  }

  final themeViewModel = ThemeViewModel();
  await themeViewModel.init();

  setupLogger();

  const configuredApp = AppConfig(
    appName: 'DEV Flutter Provider Application Starter',
    flavorName: 'dev',
    apiUrl: 'jsonplaceholder.typicode.com',
    child: Application(),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  final app = EasyLocalization(
    supportedLocales: const [englishLocale, ukrainianLocale],
    path: translationsFolderPath,
    fallbackLocale: englishLocale,
    child: ChangeNotifierProvider.value(
      value: themeViewModel,
      child: configuredApp,
    ),
  );

  runApp(app);
}
