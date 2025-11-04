import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:cached_network_image/cached_network_image.dart';

extension ImageRadiusOption on double {
  /// radius 0.0
  double get none => 0.0;

  /// radius 4.0
  double get roundedMin => 4.0;

  /// radius 8.0
  double get roundedMedium => 8.0;

  /// radius 12.0
  double get roundedLarge => 12.0;

  /// radius 16.0
  double get roundedExtraLarge => 16.0;

  /// radius 999999999999
  double get circle => 999999999999.0;
}

enum ImageRadius {
  /// radius 0.0
  none(0.0),

  /// radius 4.0
  roundedMin(4.0),

  /// radius 8.0
  roundedMedium(8.0),

  /// radius 12.0
  roundedLarge(12.0),

  /// radius 16.0
  roundedExtraLarge(16.0),

  /// radius 999999999999
  circle(999999999999);

  const ImageRadius(this.radius);

  /// value radius [double]
  final double radius;
}

class ImageCustomCache extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final Size? size;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool showLoading;
  final double? radius;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry padding;
  final String? imgDefault;
  final TypeImageSrc? typeImage;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final FilterQuality filterQuality;
  final BlendMode? colorBlendMode;
  final ImageRepeat repeat;
  final Widget Function(String, DownloadProgress)? progressIndicatorBuilder;

  const ImageCustomCache(
    this.imageUrl, {
    this.tag = '',
    this.size,
    this.width,
    this.height,
    this.fit,
    this.showLoading = false,
    this.radius,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.imgDefault,
    this.progressIndicatorBuilder,
    this.typeImage,
    this.httpHeaders,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.high,
    this.useOldImageOnUrlChange = false,
    this.repeat = ImageRepeat.noRepeat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typeImg = typeImage ?? _checkType();
    if (imageUrl.trim().isEmpty) return _error();
    if (kIsWeb) return _imageModeWeb();

    if (typeImg == TypeImageSrc.network) return _imageNetwork();
    if (typeImg == TypeImageSrc.assets) return _imageAssets();
    if (typeImg == TypeImageSrc.memory) return _imageMemory();
    if (typeImg == TypeImageSrc.file) return _imageFile();
    return _error();
  }

  /// Check the type of the image (network, assets, memory or file).
  TypeImageSrc _checkType() {
    final img = imageUrl.trim();

    if (img.isEmpty) return TypeImageSrc.none;
    if (img.startsWith("asset")) return TypeImageSrc.assets;
    if (img.startsWith("http")) return TypeImageSrc.network;
    if (_isFilePath(img)) return TypeImageSrc.file;
    if (_isBase64(img)) return TypeImageSrc.memory;

    try {
      List<int> decodedBytes = base64Decode(img);
      var file = io.File('img_cache_checking.png');
      file.writeAsBytesSync(decodedBytes);
      return TypeImageSrc.memory;
    } catch (_) {
      debugPrint('Invalid base64 string');
    }

    return TypeImageSrc.none;
  }

  /// Checks if the given string is a valid Base64 encoded string.
  ///
  /// The function first verifies if the string matches the Base64 pattern,
  /// which consists of alphanumeric characters, plus (`+`), and slash (`/`),
  /// followed by zero to two equal signs (`=`) at the end for padding.
  /// If the string does not match this pattern, it returns false.
  /// If the pattern matches, it attempts to decode the string using
  /// the `base64.decode` method. If decoding succeeds, it returns true,
  /// indicating the string is a valid Base64 encoded string. If decoding
  /// fails, it catches the exception and returns false.
  bool _isBase64(String input) {
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');
    if (!base64Pattern.hasMatch(input)) {
      return false; // does not match the base pattern64
    }
    try {
      base64.decode(input); // tries to decode to confirm
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Verify if the string is a valid path in the file system.
  ///
  /// The method tries to create an object [io.file] with the PATH provided
  /// and return True if the file exists, or false otherwise.
  bool _isFilePath(String input) {
    try {
      final file = io.File(input);
      return file.existsSync();
    } catch (e) {
      return false;
    }
  }

  Future<Uint8List> _assetToUint8List(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  Widget _imageModeWeb() {
    String img = imageUrl.trim();

    if (img.contains('assets/')) {
      // img = img.replaceAll('/assets/', '/assets/assets/');

      FutureBuilder(
        future: _assetToUint8List(img),
        builder: (_, snap) {
          if (snap.hasData) {
            return Padding(
              padding: padding,
              child: ClipRRect(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(radius ?? 0),
                child: Image.memory(
                  base64Decode(img),
                  width: width ?? size?.width,
                  height: height ?? size?.height,
                  fit: fit,
                  color: color,
                  colorBlendMode: colorBlendMode,
                  filterQuality: filterQuality,
                  repeat: repeat,
                  errorBuilder: (context, url, error) => _error(),
                ).hasHero(tag),
              ),
            );
          }
          return _error(img);
        },
      );
    }

    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: Image.network(
          img,
          width: width ?? size?.width,
          height: height ?? size?.height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          repeat: repeat,
          errorBuilder: (context, url, error) => _error(),
        ).hasHero(tag),
      ),
    );
  }

  Widget _imageNetwork() {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          imageUrl: imageUrl.trim(),
          width: width ?? size?.width,
          height: height ?? size?.height,
          fit: fit,
          httpHeaders: httpHeaders,
          color: color,
          colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          repeat: repeat,
          useOldImageOnUrlChange: useOldImageOnUrlChange,
          progressIndicatorBuilder: progressIndicatorBuilder != null
              ? (_, url, dp) => progressIndicatorBuilder!(url, dp)
              : null,
          placeholder: showLoading ? (context, url) => _placeHolder() : null,
          errorWidget: (context, url, error) => _error(),
        ).hasHero(tag),
      ),
    );
  }

  Widget _imageAssets() {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: Image.asset(
          imageUrl,
          width: width ?? size?.width,
          height: height ?? size?.height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          repeat: repeat,
          frameBuilder: showLoading
              ? (_, child, __, ___) => _placeHolder()
              : null,
          errorBuilder: (context, url, error) => _error(),
        ).hasHero(tag),
      ),
    );
  }

  Widget _imageMemory() {
    final imp = base64ToUint8List(imageUrl);

    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: Image.memory(
          imp,
          width: width ?? size?.width,
          height: height ?? size?.height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          repeat: repeat,
          frameBuilder: showLoading
              ? (_, child, __, ___) => _placeHolder()
              : null,
          errorBuilder: (context, url, error) => _error(),
        ).hasHero(tag),
      ),
    );
  }

  Widget _imageFile() {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: Image.file(
          io.File(imageUrl),
          width: width ?? size?.width,
          height: height ?? size?.height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          repeat: repeat,
          frameBuilder: showLoading
              ? (_, child, __, ___) => _placeHolder()
              : null,
          errorBuilder: (context, url, error) => _error(),
        ).hasHero(tag),
      ),
    );
  }

  Widget _placeHolder() {
    return Container(
      width: width ?? size?.width,
      height: height ?? size?.height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _error([String? img]) {
    return Center(
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: Image.asset(
          img ?? imgDefault ?? 'assets/images/icon.png',
          width: width ?? size?.width,
          height: height ?? size?.height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          repeat: repeat,
        ),
      ),
    );
  }
}

/// Type Image
enum TypeImageSrc { network, assets, memory, file, none }

extension HeroExtension on Widget {
  Widget hasHero(String tag) {
    return tag.trim().isEmpty ? this : Hero(tag: tag, child: this);
  }
}

Uint8List base64ToUint8List(String base64String) {
  try {
    return base64Decode(base64String);
  } catch (e) {
    return Uint8List(0);
  }
}
