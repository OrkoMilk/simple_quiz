import 'package:provider_starter_app/models/post.dart';
import 'package:provider_starter_app/network/api_client.dart';
import 'package:provider_starter_app/utils/logger.dart';

const String postsPath = '/posts';

class ApiService {
  late ApiClient _apiClient;

  ApiService(String baseApiUrl) {
    _apiClient = ApiClient(baseApiUrl: baseApiUrl);
  }

  /// Example HTTP request usage with params:
  ///       final res = await _apiClient.get('/comments', params: {
  ///         'postId': '1',
  ///       });
  Future<List<PostModel>> fetchPostsData() async {
    try {
      final res = await _apiClient.get(postsPath);
      return List<PostModel>.from(res.map((k) => PostModel.fromJson(k)));
    } catch (e) {
      log.severe('fetchPostsData error: $e');
      rethrow;
    }
  }

  Future<PostModel> publishPostData(String jsonBody) async {
    try {
      final response = await _apiClient.post(postsPath, jsonBody);
      return PostModel.fromJson(response);
    } catch (e) {
      log.severe('publishPostData error: $e');
      rethrow;
    }
  }
}
