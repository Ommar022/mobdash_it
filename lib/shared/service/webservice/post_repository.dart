import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:mobdash_it/model/post_model.dart';
import 'package:mobdash_it/shared/service/webservice/web_service.dart';
import '../../utils/utils.dart';

class PostRepository extends WebService {

  Future<List<PostModel>?> getPosts({required String postType}) async {
    try {
      final response = await post(action: 'get_post&post_type=$postType', body: {});

      if (response == null) {
        log('Response is null');
        return null;
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is Map<String, dynamic>) {
        if (jsonResponse['desc'] is List) {
          final postList = (jsonResponse['desc'] as List)
              .map((data) => PostModel.fromJson(data))
              .toList();
          return postList;
        } else {
          log('Error: ${jsonResponse['error_msg']}');
          return null;
        }
      } else {
        log('Unexpected response structure');
        return null;
      }
    } catch (e) {
      log('Error occurred during GET request: $e');
      return null;
    }
  }

  Future<List<PostModel>?> getServices() async {
    try {
      final response = await post(action: 'get_services', body: {});

      if (response == null) {
        log('Response is null');
        return null;
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is Map<String, dynamic>) {
        if (jsonResponse['desc'] is List) {
          final postList = (jsonResponse['desc'] as List)
              .map((data) => PostModel.fromJson(data))
              .toList();
          return postList;
        } else {
          log('Error: ${jsonResponse['error_msg']}');
          return null;
        }
      } else {
        log('Unexpected response structure');
        return null;
      }
    } catch (e) {
      log('Error occurred during GET request: $e');
      return null;
    }
  }


  Future<Map<String, dynamic>?> uploadPost({
    required String name,
    required String description,
    required String type,
    required File image,
    required File file,
    String? price,
  }) async {
    final response = await multipart(
      action: 'create_post',
      body: {
        'post_title': name,
        'post_description': description,
        'post_type': type,
        'price': price,
        // 'post_thumb': image,
        // 'attatchment_url': file,
      },
      image: image,
      file: file,
    );

    try {
      if (response == null) {
        return null;
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse == null) {
        return null;
      }
      if (jsonResponse['status'] == false) {
        Utils.showCustomToast(msg: jsonResponse['error_msg']);
        return null;
      } else {
        return jsonResponse['data'];
      }
    } catch (e) {
      log('Error occurred during response handling: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createServices({
    required String name,
    required String description,
    required File image,

    String? price,
  }) async {
    final response = await multipart(
      action: 'create_services',
      body: {
        'post_title': name,
        'post_description': description,
        'price': price,
        // 'post_thumb': image,
        // 'attatchment_url': file,
      },
      image: image,
    );

    try {
      if (response == null) {
        return null;
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse == null) {
        return null;
      }
      if (jsonResponse['status'] == false) {
        Utils.showCustomToast(msg: jsonResponse['error_msg']);
        return null;
      } else {
        return jsonResponse['data'];
      }
    } catch (e) {
      log('Error occurred during response handling: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> rating({
    required int productId,
    required int userId,
    required int rating,
    // required String comment,
    // required File image,

  }) async {
    final response = await multipart(
      action: 'rating',
      body: {
        'product_id': productId,
        'user_id': userId,
        // 'comment': comment,
        'rating': rating,
        // 'post_thumb': image,
        // 'attatchment_url': file,
      },
      // image: image,
    );

    try {
      if (response == null) {
        return null;
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse == null) {
        return null;
      }
      if (jsonResponse['status'] == false) {
        Utils.showCustomToast(msg: jsonResponse['error_msg']);
        return null;
      } else {
        return jsonResponse['data'];
      }
    } catch (e) {
      log('Error occurred during response handling: $e');
      return null;
    }
  }
}
