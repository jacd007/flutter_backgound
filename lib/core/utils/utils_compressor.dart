/* import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math' as math;

class UtilsCompressor {
  UtilsCompressor._();

  /// Método para calcular el factor de escala que evita agrandar imágenes más pequeñas.
  /// Retorna un double >= 1.0, donde 1.0 significa sin escalado (no agrandar).
  static double calcScale({
    required double srcWidth,
    required double srcHeight,
    required double minWidth,
    required double minHeight,
  }) {
    final scaleW = srcWidth / minWidth;
    final scaleH = srcHeight / minHeight;
    final scale = math.max(1.0, math.min(scaleW, scaleH));
    return scale;
  }

  static Future<Uint8List?> compressFileFromPath(
    String path, {
    int quality = 80,
    int minWidth = 1024,
    int minHeight = 1024,
    int rotate = 0,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
  }) async {
    return compressFile(
      file: File(path),
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
      rotate: rotate,
      format: format,
      keepExif: keepExif,
    );
  }

  static Future<String?> compressAndSaveFromPath(
    String path, {
    String? outputPath,
    int quality = 80,
    int minWidth = 1024,
    int minHeight = 1024,
    int rotate = 0,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
  }) async {
    final file = await compressAndSave(
      inputFile: File(path),
      outputPath: outputPath,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
      rotate: rotate,
      format: format,
      keepExif: keepExif,
    );
    return file?.path;
  }

  /// Comprime una imagen desde archivo con parámetros configurables.
  /// Recalcula dimensiones para evitar agrandar imágenes pequeñas.
  static Future<Uint8List?> compressFile({
    required File file,
    int quality = 80,
    int minWidth = 1024,
    int minHeight = 1024,
    int rotate = 0,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
  }) async {
    try {
      final decodedImage = await decodeImageFromList(await file.readAsBytes());
      final scale = calcScale(
        srcWidth: decodedImage.width.toDouble(),
        srcHeight: decodedImage.height.toDouble(),
        minWidth: minWidth.toDouble(),
        minHeight: minHeight.toDouble(),
      );
      final targetWidth = (decodedImage.width / scale).round();
      final targetHeight = (decodedImage.height / scale).round();

      return await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: quality.clamp(0, 100),
        minWidth: targetWidth,
        minHeight: targetHeight,
        rotate: rotate,
        format: format,
        keepExif: keepExif,
      );
    } catch (e) {
      debugPrint('Error comprimiendo archivo: $e');
      return null;
    }
  }

  /// Comprime una imagen desde bytes con parámetros configurables.
  /// Recalcula dimensiones para evitar agrandar imágenes pequeñas.
  static Future<Uint8List?> compressBytes({
    required Uint8List bytes,
    int quality = 80,
    int minWidth = 1024,
    int minHeight = 1024,
    int rotate = 0,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
  }) async {
    try {
      final decodedImage = await decodeImageFromList(bytes);
      final scale = calcScale(
        srcWidth: decodedImage.width.toDouble(),
        srcHeight: decodedImage.height.toDouble(),
        minWidth: minWidth.toDouble(),
        minHeight: minHeight.toDouble(),
      );
      final targetWidth = (decodedImage.width / scale).round();
      final targetHeight = (decodedImage.height / scale).round();

      return await FlutterImageCompress.compressWithList(
        bytes,
        quality: quality.clamp(0, 100),
        minWidth: targetWidth,
        minHeight: targetHeight,
        rotate: rotate,
        format: format,
        keepExif: keepExif,
      );
    } catch (e) {
      debugPrint('Error comprimiendo bytes: $e');
      return null;
    }
  }

  /// Comprime y guarda la imagen en un archivo.
  /// Recalcula dimensiones para evitar agrandar imágenes pequeñas.
  static Future<File?> compressAndSave({
    required File inputFile,
    String? outputPath,
    int quality = 80,
    int minWidth = 1024,
    int minHeight = 1024,
    int rotate = 0,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
  }) async {
    try {
      final decodedImage = await decodeImageFromList(
        await inputFile.readAsBytes(),
      );
      final scale = calcScale(
        srcWidth: decodedImage.width.toDouble(),
        srcHeight: decodedImage.height.toDouble(),
        minWidth: minWidth.toDouble(),
        minHeight: minHeight.toDouble(),
      );
      final targetWidth = (decodedImage.width / scale).round();
      final targetHeight = (decodedImage.height / scale).round();

      final targetPath = outputPath ?? await _generateTempPath(format);
      final file = await FlutterImageCompress.compressAndGetFile(
        inputFile.absolute.path,
        targetPath,
        quality: quality.clamp(0, 100),
        minWidth: targetWidth,
        minHeight: targetHeight,
        rotate: rotate,
        format: format,
        keepExif: keepExif,
      );

      return file == null ? null : File(file.path);
    } catch (e) {
      debugPrint('Error guardando archivo comprimido: $e');
      return null;
    }
  }

  static Future<String> _generateTempPath(CompressFormat format) async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.${_formatExtension(format)}';
  }

  static String _formatExtension(CompressFormat format) {
    return format.toString().split('.').last.toLowerCase();
  }
}
 */
