import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheManager {
  ImageCacheManager._();

  /// Guarda una imagen codificada en Base64 en el almacenamiento temporal
  /// y devuelve la ruta del archivo.
  ///
  /// [base64String]: La cadena Base64 de la imagen.
  /// [fileName]: El nombre deseado para el archivo de imagen (ej. 'imagen_perfil.png').
  ///
  /// Retorna un [Future<String?>] que contendrá la ruta del archivo
  /// si la operación fue exitosa, o null si hubo un error.
  static Future<String?> saveBase64ImageToTemp(
    String base64String,
    String fileName,
  ) async {
    try {
      // Decodifica la cadena Base64 a bytes
      final decodedBytes = base64Decode(base64String);

      // Obtiene el directorio de caché de la aplicación
      // En iOS es el directorio 'Caches', en Android es el directorio 'cache'.
      final Directory tempDir = await getTemporaryDirectory();

      // Crea la ruta completa del archivo
      final String filePath = '${tempDir.path}/$fileName';

      // Crea el archivo y escribe los bytes decodificados
      final File file = File(filePath);
      await file.writeAsBytes(decodedBytes);

      // Devuelve la ruta del archivo guardado
      return filePath;
    } catch (e) {
      debugPrint(
        'Error al guardar la imagen en el almacenamiento temporal: $e',
      );
      return null;
    }
  }

  /// Limpia el directorio temporal de imágenes.
  ///
  /// Puede ser útil para gestionar el espacio de almacenamiento.
  static Future<void> clearTempImageCache() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
        debugPrint('Directorio temporal de imágenes limpiado.');
      }
    } catch (e) {
      debugPrint('Error al limpiar el directorio temporal de imágenes: $e');
    }
  }
}
