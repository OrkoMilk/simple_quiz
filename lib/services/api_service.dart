import 'package:flutter_simple_quizapp/models/answer_qiuz_model.dart';
import 'package:flutter_simple_quizapp/models/quiz_model.dart';
import 'package:flutter_simple_quizapp/network/api_client.dart';
import 'package:flutter_simple_quizapp/utils/logger.dart';

const String postsPath = '/posts';
const String quizPostsPath = 'v3/5d4b54e3-7172-43d0-b924-fe5d51707e8f';
const String answerQuizPostsPath = 'v3/0aeb7418-0c94-41ce-8f5b-09889cf37a58';

class ApiService {
  late ApiClient _apiClient;

  ApiService(String baseApiUrl) {
    _apiClient = ApiClient(baseApiUrl: baseApiUrl);
  }

  /// Example HTTP request usage with params:
  ///       final res = await _apiClient.get('/comments', params: {
  ///         'postId': '1',
  ///       });

  Future<List<QuizModel>> fetchQuizPostsData() async {
    try {
      final res = await _apiClient.get(quizPostsPath);
      return List<QuizModel>.from(res.map((k) => QuizModel.fromJson(k)));
    } catch (e) {
      log.severe('fetchPostsData error: $e');
      rethrow;
    }
  }

  Future<List<OneAnswerQuizModel>> fetchAnswerQuizPostsData() async {
    try {
      final res = await _apiClient.get(answerQuizPostsPath);
      return List<OneAnswerQuizModel>.from(res.map((k) => OneAnswerQuizModel.fromJson(k)));
    } catch (e) {
      log.severe('fetchPostsData error: $e');
      rethrow;
    }
  }
}
