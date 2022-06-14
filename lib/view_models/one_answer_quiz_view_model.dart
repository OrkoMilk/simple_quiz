import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_quizapp/database/home_dao.dart';
import 'package:flutter_simple_quizapp/models/answer_qiuz_model.dart';


class OneAnswerQuizViewModel extends ChangeNotifier {
  HomeDao _homeDao = HomeDao();
  StreamSubscription? _dbSubscription;

  List<OneAnswerQuizModel> _inMemoryOneAnswerQuizList = [];

  int _correctAnswerCounter = 0;
  int _quizIndex = 0;
  late  bool _isFinished = false;

  bool get isFinished => _isFinished;
  int get quizIndex => _quizIndex;
  int get counter => _correctAnswerCounter;

  List<OneAnswerQuizModel> get inMemoryQuizList => _inMemoryOneAnswerQuizList;

  OneAnswerQuizViewModel() {
    _init();
  }

  void _init() {
    _homeDao = HomeDao();
    _listenToOffersUpdates();
  }

  Future<void> insertOneAnswerQuiz(OneAnswerQuizModel quizModel) async {
    await _homeDao.saveOneAnswerQuiz(quizModel);
  }

  Future<void> clearStore() async {
    await _homeDao.clearStore();
  }

  void checkCorrectAnswer({required String answer, required List<OneAnswerQuizModel> quiz}) {
    if (answer == quiz[_quizIndex].rightAnswer) {
      insertOneAnswerQuiz(quiz[_quizIndex]);
      _correctAnswerCounter++;
    }
    _quizIndex++;
    if (_quizIndex == quiz.length){
      _isFinished = true;
      _quizIndex = 0;
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  Future<void> _listenToOffersUpdates() async {
    _dbSubscription = await _homeDao.listenToUpdates((DatabaseSnapshotList snapshots) {
      _inMemoryOneAnswerQuizList = HomeDao.snapshotsToOneAnswerQuizList(snapshots);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _dbSubscription?.cancel();
    super.dispose();
  }
}