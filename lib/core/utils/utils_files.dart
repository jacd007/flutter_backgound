/* // ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

enum TypeFile { singleGallery, singleCamera, multiGallery }

class UtilsFiles {
  UtilsFiles._();

  /// create [File] from [Uint8List]
  static Future<File> createFileFromUint8List(
    Uint8List bytes,
    String ext, [
    String auxName = '',
  ]) async {
    debugPrint('Create file from Uint8List');
    final dir = await getApplicationDocumentsDirectory();
    // Directory dir1 = await DownloadsPathProvider.downloadsDirectory ?? dir;
    final epoch = DateTime.now().millisecondsSinceEpoch.toString();
    final String name = auxName.isEmpty ? epoch : auxName;
    File file = File("${dir.path}/$name.$ext");
    File f = await file.writeAsBytes(bytes);
    debugPrint('File Created [${f.path}]');
    return f;
  }

  /// get [File] from assets path
  static Future<File> getFileFromAssets(String path) async {
    debugPrint('Create file from assets');
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    //final file = File('${(await getExternalStorageDirectory())!.path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    debugPrint('File Created [${file.path}]');
    return file;
  }

  /// readJsonAssets
  static Future readJson(String pathAssetsJson) async {
    final String response = await rootBundle.loadString(pathAssetsJson);
    final data = await jsonDecode(response);
    return data;
  }

  /// Create File From data
  ///
  /// [data] as File
  ///
  /// [data] as String by Base 64
  ///
  /// [data] as Uint8List
  ///
  /// [extension] is required. Default is "PNG"
  ///
  static Future<String> createFile({
    required Object data,
    required String extension,
    String? name,
  }) async {
    try {
      // get path
      final Directory appDir = await getApplicationDocumentsDirectory();

      // bytes convert
      late Uint8List bytes;
      if (data is String) {
        bytes = base64Decode(data);
      } else if (data is File) {
        bytes = (data).readAsBytesSync();
      } else {
        bytes = data as Uint8List;
      }
      // file name
      final fileName = name ?? DateTime.now().millisecondsSinceEpoch.toString();
      final ext = extension.isNotEmpty ? 'png' : extension;
      // create file
      File file = File("${appDir.path}/$fileName.$ext");
      // write file from bytes
      await file.writeAsBytes(bytes);
      debugPrint('File created');
      return file.path;
    } catch (e) {
      debugPrint('File create error: $e');
      return '';
    }
  }

  static Future<String> createJsonFile(String jsonString, String name) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$name.json';
      final file = File(path);

      final result = await file.writeAsString(jsonString);

      debugPrint('JSON file created at: $path');
      return result.path;
    } on Exception catch (e) {
      debugPrint('Error creating JSON file: $e');
      return '';
    }
  }

  static String regexPatternBase64(String src) {
    final pattern = r'^data:image\/(.*?);base64,'; // regex pattern
    final RegExp regex = RegExp(pattern);
    final photo = src.replaceAll(regex, '');
    return photo;
  }

  static Future<Uint8List> assetToUint8List(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  static Future<File?> getImageFile({
    TypeFile type = TypeFile.singleGallery,
    bool isCompress = true,
  }) async {
    final ImagePicker picker = ImagePicker();

    if (type == TypeFile.singleGallery) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1250,
        maxWidth: 1250,
        imageQuality: isCompress ? 35 : 100,
      );
      return image == null ? null : File(image.path);
    } else if (type == TypeFile.singleCamera) {
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1250,
        maxWidth: 1250,
        imageQuality: isCompress ? 35 : 100,
      );
      return photo == null ? null : File(photo.path);
    } else {
      return null;
    }
  }

  static Future<List<File>> getImageMultiple({
    TypeFile type = TypeFile.singleGallery,
    bool isCompress = true,
    int? limit,
  }) async {
    final ImagePicker picker = ImagePicker();

    if (type == TypeFile.singleGallery) {
      final List<XFile> images = await picker.pickMultiImage(
        maxHeight: 1250,
        maxWidth: 1250,
        limit: limit,
        imageQuality: isCompress ? 35 : 100,
      );
      return images.map((e) => File(e.path)).toList();
    } else if (type == TypeFile.singleCamera) {
      final List<XFile> photos = await picker.pickMultipleMedia(
        maxHeight: 1250,
        maxWidth: 1250,
        limit: limit,
        imageQuality: isCompress ? 35 : 100,
      );
      return photos.map((e) => File(e.path)).toList();
    } else {
      return [];
    }
  }

  static Future<String> fileToBase64(String path) async {
    try {
      File file = File(path);
      Uint8List bytes = await file.readAsBytes();
      String base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      debugPrint('File to base64 error: $e');
      return path;
    }
  }

  static Future<String> bytesToBase64(Uint8List bytes) async {
    try {
      String base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      debugPrint('File to base64 error: $e');
      return '';
    }
  }

  static Uint8List base64ToUint8List(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      throw Exception('Error al decodificar Base64: $e');
    }
  }

  static Future<String> assetToBase64(String assetPath) async {
    try {
      // Read the file from Assets like bytes
      ByteData byteData = await rootBundle.load(assetPath);
      Uint8List bytes = byteData.buffer.asUint8List();

      // Codify the BYTES BASE64
      String base64String = base64Encode(bytes);

      return base64String;
    } catch (e) {
      debugPrint("Error converting the file based64: $e");
      return '';
    }
  }
}
 */
