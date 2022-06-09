import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider_starter_app/app.dart';
import 'package:provider_starter_app/app_config.dart';
import 'package:provider_starter_app/view_models/theme_view_model.dart';

import 'utils/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeViewModel = ThemeViewModel();
  await themeViewModel.init();

  setupLogger();

  const configuredApp = AppConfig(
    appName: 'Flutter Provider Application Starter',
    flavorName: 'prod',
    apiUrl: 'prod.jsonplaceholder.typicode.com',
    child: Application(),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

}
