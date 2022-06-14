import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_quizapp/common/app_bar_config.dart';
import 'package:flutter_simple_quizapp/routes.dart';
import 'package:flutter_simple_quizapp/view_models/api_view_model.dart';
import 'package:flutter_simple_quizapp/view_models/quiz_view_model.dart';
import 'package:provider/provider.dart';
import '../generated/locale_keys.g.dart';
import '../main_dev.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final postsProvider = context.watch<ApiViewModel>();
    final quizProvider = context.watch<QuizViewModel>();
    quizProvider.clearStore();

    return Scaffold(
      appBar: defaultAppBar(context, tr(LocaleKeys.app_bar_title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildChangeLangButton(
                    tr(LocaleKeys.language_english), englishLocale),
                _buildChangeLangButton(
                    tr(LocaleKeys.language_ukrainian), ukrainianLocale),
              ]),
          Center(
            child: ElevatedButton(
              onPressed: () {
                postsProvider.fetchPosts();
                Navigator.pushReplacementNamed(context, quizScreenRoute);
              },
              child: Text('#1: ${tr(LocaleKeys.start_quiz)}'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                postsProvider.fetchQuizPosts();
                Navigator.pushReplacementNamed(context, oneAnswerQuizScreenRoute);
              },
              child: Text('#2: ${tr(LocaleKeys.start_quiz)}'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, scoreScreen);
              },
              child:  Text(tr(LocaleKeys.go_to_score)),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildChangeLangButton(String languageName, Locale locale) {
    return ElevatedButton(
      onPressed: () {
        context.setLocale(locale);
      },
      child: Text(languageName),
    );
  }
}
