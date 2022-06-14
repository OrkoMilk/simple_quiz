import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_quizapp/generated/locale_keys.g.dart';
import 'package:flutter_simple_quizapp/view_models/one_answer_quiz_view_model.dart';
import 'package:flutter_simple_quizapp/view_models/quiz_view_model.dart';
import 'package:provider/provider.dart';

import '../common/app_bar_config.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizViewModel>();
    final oneAnswerQuizProvider = context.watch<OneAnswerQuizViewModel>();

    return Scaffold(
      appBar: defaultAppBar(context, tr(LocaleKeys.app_bar_title)),
      body: Center(
        child: Text(
          'YOUR SCORE: ${quizProvider.counter + oneAnswerQuizProvider.counter}',
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
