import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_quizapp/generated/locale_keys.g.dart';
import 'package:flutter_simple_quizapp/network/response.dart';
import 'package:flutter_simple_quizapp/view_models/posts_view_model.dart';
import 'package:flutter_simple_quizapp/view_models/quiz_view_model.dart';
import 'package:provider/provider.dart';

import '../common/app_bar_config.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final apiResponse = context.watch<ApiViewModel>().postsListResponse.status;

    return Scaffold(
        appBar: defaultAppBar(context, tr(LocaleKeys.app_bar_title)),
        body: apiResponse.isCompleted
            ? _buildQuiz()
            : const Center(child: CircularProgressIndicator()));
  }

  Widget _buildQuiz() {
    final quizProvider = context.watch<QuizViewModel>();
    final apiResponse = context.watch<ApiViewModel>().postsListResponse;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (quizProvider.isFinished) ...{
          Center(
            child: ElevatedButton(
              onPressed: () {
                //TODO: back to home screen
              },
              child: const Text('Back to home screen'),
            ),
          ),
        } else ...{
          Text(
            'Question #${apiResponse.data![quizProvider.quizIndex].id}',
            style: const TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              apiResponse.data![quizProvider.quizIndex].question!,
              // quizProvider.quizQuestion,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    quizProvider.checkCorrectAnswer(
                      answer: true,
                      quiz: apiResponse.data![quizProvider.quizIndex],
                    );
                  },
                  child: const Text('True'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    quizProvider.checkCorrectAnswer(
                      answer: false,
                      quiz: apiResponse.data![quizProvider.quizIndex],
                    );
                  },
                  child: const Text('False'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Correct answers = ${quizProvider.counter.toString()}',
            ),
          ),
        }
      ],
    );
  }
}
