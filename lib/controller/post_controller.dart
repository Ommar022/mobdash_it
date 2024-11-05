import 'dart:io';
import 'package:get/get.dart';
import 'package:mobdash_it/model/post_model.dart';
import 'package:mobdash_it/shared/service/webservice/post_repository.dart';
import 'package:mobdash_it/shared/utils/utils.dart';

class PostController extends GetxController {
  final _posts = RxList<PostModel>();
  final _isLoading = RxBool(false);
  var uploadedFileName = ''.obs;

  void setUploadedFileName(String fileName) {
    uploadedFileName.value = fileName;
  }

  Future<void> getPosts({required String postType}) async {
    _isLoading(true);
    final result = await PostRepository().getPosts(postType: postType);
    if (result != null) {
      _posts.value = result;
    }
    _isLoading(false);
  }

  Future<void> getServices() async {
    _isLoading(true);
    final result = await PostRepository().getServices();
    if (result != null) {
      _posts.value = result;
    }
    _isLoading(false);
  }

  bool get isLoading => _isLoading.value;
  List<PostModel> get posts => _posts;

  Future<void> uploadPost({
    required final String name,
    required final String description,
    required final String type,
    required final File image,
    required final File file,
    final String? price,
  }) async {
    if (name.isEmpty) {
      Utils.showCustomToast(msg: 'Please fill in the name.');
      return;
    }
    if (description.isEmpty) {
      Utils.showCustomToast(msg: 'Please fill in the description.');
      return;
    }
    if (!image.existsSync()) {
      Utils.showCustomToast(msg: 'Please upload a valid image.');
      return;
    }

    _isLoading(true);
    final result = await PostRepository().uploadPost(
      name: name,
      price: price,
      description: description,
      image: image,
      file: file,
      type: type,
    );
    _isLoading(false);
  }

  Future<void> createServices({
    required final String name,
    required final String description,
    required final File image,
    final String? price,
  }) async {
    if (name.isEmpty) {
      Utils.showCustomToast(msg: 'Please fill in the name.');
      return;
    }
    if (description.isEmpty) {
      Utils.showCustomToast(msg: 'Please fill in the description.');
      return;
    }
    if (!image.existsSync()) {
      Utils.showCustomToast(msg: 'Please upload a valid image.');
      return;
    }

    _isLoading(true);
    final result = await PostRepository().createServices(
      name: name,
      price: price,
      description: description,
      image: image,

    );
    _isLoading(false);
  }

  Future<void> rating({
    required final int productId,
    required final int userId,
    required final int rating,

  }) async {


    _isLoading(true);
    final result = await PostRepository().rating(
      productId: productId,
      userId: userId,
      rating: rating,

    );
    _isLoading(false);
  }
}
