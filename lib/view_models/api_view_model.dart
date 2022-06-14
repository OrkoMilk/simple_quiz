import 'package:flutter/material.dart';
import 'package:flutter_simple_quizapp/models/answer_qiuz_model.dart';
import 'package:flutter_simple_quizapp/models/quiz_model.dart';
import 'package:flutter_simple_quizapp/network/response.dart';
import 'package:flutter_simple_quizapp/services/api_service.dart';
import 'package:flutter_simple_quizapp/utils/logger.dart';


class ApiViewModel extends ChangeNotifier {
  final ApiService _apiService;

  NetworkResponse<List<QuizModel>> postsListResponse = NetworkResponse.none();
  NetworkResponse<List<OneAnswerQuizModel>> quizListResponse = NetworkResponse.none();

  NetworkResponse publishPostResponse = NetworkResponse.none();

  ApiViewModel(this._apiService);

  Future<void> fetchPosts() async {
    postsListResponse = NetworkResponse<List<QuizModel>>.loading('Fetching posts...');
    notifyListeners();
    try {
      final postList = await _apiService.fetchQuizPostsData();
      postsListResponse = NetworkResponse.completed(postList);
    } catch (e) {
      postsListResponse = NetworkResponse.error(e.toString());
      log.fine('fetchPosts error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchQuizPosts() async {
    quizListResponse = NetworkResponse<List<OneAnswerQuizModel>>.loading('Fetching posts...');
    notifyListeners();
    try {
      final postList = await _apiService.fetchAnswerQuizPostsData();
      quizListResponse = NetworkResponse.completed(postList);
    } catch (e) {
      quizListResponse = NetworkResponse.error(e.toString());
      log.fine('fetchPosts error: $e');
    } finally {
      notifyListeners();
    }
  }

  String get postsText {
    switch (postsListResponse.status) {
      case Status.completed:
        return '${postsListResponse.data!.length}';
      case Status.loading:
      case Status.error:
        return postsListResponse.message ?? '';
      case Status.none:
      default:
        return '';
    }
  }
}
