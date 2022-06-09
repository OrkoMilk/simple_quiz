import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_quizapp/app_config.dart';
import 'package:flutter_simple_quizapp/routes.dart';
import 'package:flutter_simple_quizapp/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'view_models/home_view_model.dart';
import 'view_models/posts_view_model.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig.of(context)!;
    final _apiService = ApiService(appConfig.apiUrl);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => PostsViewModel(_apiService)),
      ],
      child: Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
        return MaterialApp(
          title: 'Flutter Provider Starter',
          theme: themeViewModel.getThemeData,
          darkTheme: themeViewModel.currentDarkTheme,
          initialRoute: splashScreenRoute,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: applicationRoutes,
        );
      }),
    );
  }
}
