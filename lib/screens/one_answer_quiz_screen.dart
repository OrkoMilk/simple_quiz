import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_quizapp/generated/locale_keys.g.dart';
import 'package:flutter_simple_quizapp/network/response.dart';
import 'package:flutter_simple_quizapp/view_models/one_answer_quiz_view_model.dart';
import 'package:flutter_simple_quizapp/view_models/posts_view_model.dart';
import 'package:provider/provider.dart';

import '../common/app_bar_config.dart';
import '../routes.dart';

class OneAnswerQuizScreen extends StatefulWidget {
  const OneAnswerQuizScreen({Key? key}) : super(key: key);

  @override
  State<OneAnswerQuizScreen> createState() => _OneAnswerQuizScreenState();
}

class _OneAnswerQuizScreenState extends State<OneAnswerQuizScreen> {
  @override
  Widget build(BuildContext context) {
    final apiResponse = context.watch<ApiViewModel>().quizListResponse.status;

    return Scaffold(
        appBar: defaultAppBar(context, tr(LocaleKeys.app_bar_title)),
        body: apiResponse.isCompleted
            ? _buildQuiz()
            : const Center(child: CircularProgressIndicator()));
  }

  Widget _buildQuiz() {
    final quizProvider = context.watch<OneAnswerQuizViewModel>();
    final apiResponse = context.watch<ApiViewModel>().quizListResponse;
    final answers = apiResponse.data![quizProvider.quizIndex].answers ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (quizProvider.isFinished) ...{
          Center(
            child: Column(
              children: [
                Text('Your score is: ${quizProvider.counter.toString()}'),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, homeScreenRoute);
                    },
                    child: const Text('Back to home screen'),
                  ),
                ),
              ],
            ),
          ),
        } else ...{
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              'Question #${apiResponse.data![quizProvider.quizIndex].id}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              apiResponse.data![quizProvider.quizIndex].question!,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                itemCount: answers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        quizProvider.checkCorrectAnswer(
                          answer: answers[index],
                          quiz: apiResponse.data!,
                        );
                      },
                      child: Text(answers[index]
                          .toString()),
                    ),
                  );
                }),
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
