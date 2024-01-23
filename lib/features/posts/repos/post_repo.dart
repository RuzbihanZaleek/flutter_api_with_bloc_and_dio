import 'package:dio/dio.dart';
import 'package:flutter_api_request_with_bloc_and_dio/features/posts/models/post_data_ui_model.dart';

class PostRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    final dio = Dio();
    List<PostDataUiModel> posts = [];

    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      for (int i = 0; i < response.data.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromJson(response.data[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> postData() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          "title": "Flutter Bloc",
          "body": "Flutter bloc with dio",
          "userId": 12
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
