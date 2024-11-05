import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import '../../index.dart';

class WebService {

  Future<http.Response?> post({
    required final String action,
    required final Map<String, dynamic> body,
  }) async {
    if (kDebugMode) {
      log('API URL : ${Uri.parse('$kRootLink$action')}');
      log('body: $body');
    }

    try {
      final response = await http.post(Uri.parse('$kRootLink$action'), body: body);
      final jsonResponse = jsonDecode(response.body);

      if (kDebugMode) {
        log('Response For : ${Uri.parse('$kRootLink$action')} : ${jsonResponse}');
      }
      return response;
    } catch (e) {
      log('Error occurred during POST request: $e');
      rethrow;
    }
    return null;
  }

  Future<http.Response?> multipart({
    required final String action,
    required final Map<String, dynamic> body,
    final File? file,
    final File? image,  // Image is now nullable
  }) async {
    try {
      if (file != null && !file.existsSync()) {
        print('File not found: ${file.path}');
        return null;
      }

      if (image != null && !image.existsSync()) {  // Check if image exists
        print('Image file not found: ${image.path}');
        return null;
      }

      final request = http.MultipartRequest('POST', Uri.parse('$kRootLink$action'));

      if (kDebugMode) {
        request.headers.forEach((key, value) {
          log('REQUEST HEADERS: $key - $value');
        });
      }

      if (image != null) {
        String imageName = image.path.split('/').last;
        String imageMimeType;
        if (imageName.endsWith('.jpg') || imageName.endsWith('.jpeg')) {
          imageMimeType = 'image/jpeg';
        } else if (imageName.endsWith('.png')) {
          imageMimeType = 'image/png';
        } else {
          imageMimeType = 'application/octet-stream'; // fallback
        }

        request.files.add(
          await http.MultipartFile.fromPath(
            "post_thumb",
            image.path,
            contentType: MediaType.parse(imageMimeType),
          ),
        );
      }

      if (file != null) {
        String fileName = file.path.split('/').last;
        String fileMimeType;

        if (fileName.endsWith('.pdf')) {
          fileMimeType = 'application/pdf';
        } else if (fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
          fileMimeType = 'application/msword';
        } else if (fileName.endsWith('.text')) {
          fileMimeType = 'text/plain';
        } else if (fileName.endsWith('.zip')) {
          fileMimeType = 'application/zip';
        } else {
          fileMimeType = 'application/octet-stream';
        }

        request.files.add(
          await http.MultipartFile.fromPath(
            "attatchment_url",
            file.path,
            contentType: MediaType.parse(fileMimeType),
          ),
        );
      }

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (kDebugMode) {
        request.fields.forEach((key, value) {
          log('REQUEST FIELDS: $key - $value');
        });
      }

      if (kDebugMode) {
        request.files.forEach((file) {
          log('File Name: ${file.filename}');
          log('Content Type: ${file.contentType}');
          log('File length: ${file.length}');
        });
      }

      if (image != null) {
        log('Image Path: ${image.path}');
        log('Image exist? ${await image.exists() ? true : false}');
      }

      if (file != null) {
        log('File Path: ${file.path}');
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      log('API URL: ${Uri.parse('$kRootLink$action')}');
      log('BODY: $body');
      log('RESPONSE: ${jsonDecode(responseData)}');

      final httpResponse = http.Response(responseData, response.statusCode);

      if (file != null) {
        file.deleteSync();
      }

      return httpResponse;
    } catch (e) {
      print('Error during multipart request: ${e.toString()}');
      return null;
    }
  }




}
