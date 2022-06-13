import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_quizapp/database/home_dao.dart';
import 'package:flutter_simple_quizapp/models/quiz_model.dart';


class QuizViewModel extends ChangeNotifier {
  HomeDao _homeDao = HomeDao();
  StreamSubscription? _dbSubscription;

  List<QuizModel> _inMemoryQuizList = [];

  int _correctAnswerCounter = 0;
  int _quizIndex = 0;
  late  bool _isFinished = false;

  bool get isFinished => _isFinished;
  int get quizIndex => _quizIndex;
  int get counter => _correctAnswerCounter;
  int get quizLength => _inMemoryQuizList.length;

  QuizViewModel() {
    _init();
  }

  void _init() {
    _homeDao = HomeDao();
    _listenToOffersUpdates();
  }

  Future<void> insertQuiz(QuizModel quizModel) async {
    await _homeDao.saveQuiz(quizModel);
  }

  Future<List<QuizModel>> getAllQuiz() async {
    return _homeDao.getAllQuiz();
  }

  void checkCorrectAnswer({required bool answer, required QuizModel quiz}) {
    if (answer == quiz.rightAnswer) {
      insertQuiz(quiz);
      _correctAnswerCounter++;
    }
    if (_quizIndex == quizLength){
      _isFinished = true;
      notifyListeners();
      return;
    }
    _quizIndex++;
    notifyListeners();
  }

  Future<void> _listenToOffersUpdates() async {
    _dbSubscription = await _homeDao.listenToUpdates((DatabaseSnapshotList snapshots) {
      _inMemoryQuizList = HomeDao.snapshotsToQuizList(snapshots);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _dbSubscription?.cancel();
    super.dispose();
  }
}