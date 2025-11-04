// ignore_for_file: constant_identifier_names, unused_import

import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../services/toast_service.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

enum CropAspectRatio {
  original,
  square,
  ratio3x2,
  ratio5x3,
  ratio4x3,
  ratio5x4,
  ratio7x5,
  ratio16x9,
}

enum TypeRandomGenerator { mixed, onlyCharacter, onlyNumber }

class Utils {
  Utils._();

  // get id device
  /*  static Future<String?> deviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();
    String? info;

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      info = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      info = androidDeviceInfo.id; // unique ID on Android
    }
    return info;
  }

  /// Get full device info.
  /// Example:
  /// ```
  /// {
  ///   "mac": "00-00-00-00-00-00",
  ///   "name": "iPhone",
  ///   "version": "12.0",
  ///   "model": "iPhone X",
  ///   "id": "0x000000000000",
  /// }
  /// ```
  static Future<Map<String, dynamic>> deviceInfoFull() async {
    var deviceInfo = DeviceInfoPlugin();
    Map<String, dynamic> info = {};

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      info = {
        "mac": iosDeviceInfo.identifierForVendor?.replaceAll(".", ""),
        "name": iosDeviceInfo.name,
        "version": iosDeviceInfo.systemVersion,
        "model": iosDeviceInfo.model,
        "id": iosDeviceInfo.identifierForVendor,
      }; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      info = {
        "mac": androidDeviceInfo.id.replaceAll(".", ""),
        "name":
            '${androidDeviceInfo.manufacturer} ${androidDeviceInfo.brand} ${androidDeviceInfo.model}',
        "version": androidDeviceInfo.version.release,
        "model": androidDeviceInfo.model,
        "id": androidDeviceInfo.id,
      }; // unique ID on Android
    }
    return info;
  } */

  /// mensajes personales Movil
  static toast(
    String msg, {
    toastLength = Toast.LENGTH_SHORT,
    Gravity gravity = Gravity.center,
    timeInSecForIosWeb = 1,
    backgroundColor = Colors.black54,
    textColor = Colors.white,
    fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: ToastGravity.values[gravity.index],
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static List<List<T>> limitList<T>(List<T> list, [int lengthSubList = 20]) {
    List<List<T>> subLists = [];
    for (int i = 0; i < list.length; i += lengthSubList) {
      subLists.add(
        list.sublist(
          i,
          i + lengthSubList > list.length ? list.length : i + lengthSubList,
        ),
      );
    }
    return subLists;
  }

  static String numberFormatCustom(
    double value, [
    String newPattern = "#,##0.00",
    String? locale,
  ]) {
    final oCcy = NumberFormat(newPattern, locale);
    return oCcy.format(value);
  }

  /* static Future<File?> getImageGallery(
      {TypeFile type = TypeFile.singleGallery,
      bool isCompress = true,
      bool defaults = false}) async {
    final ImagePicker picker = ImagePicker();

    if (type == TypeFile.singleGallery) {
      if (defaults) {
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        return image == null ? null : File(image.path);
      }
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1250,
        maxWidth: 1250,
        imageQuality: isCompress ? 35 : 100,
      );
      return image == null ? null : File(image.path);
    } else if (type == TypeFile.singleCamera) {
      if (defaults) {
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        return image == null ? null : File(image.path);
      }

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
  } */

  /*   static List<CropAspectRatioPreset> get cropAspectRatioList => [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]; */

  /* static Future<File> croppedImageFile(File imageFile,
      {required BuildContext context,
      String title = '',
      bool cancelCropImageAndNotReturn = false,
      CropAspectRatio cropInitial = CropAspectRatio.square,
      List<CropAspectRatioPreset>? aspectRatioPresets}) async {
    final size = MediaQuery.of(context).size;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: aspectRatioPresets ??
          [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.grey,
            initAspectRatio: CropAspectRatioPreset.values[cropInitial.index],
            lockAspectRatio: false),
        IOSUiSettings(
          title: title,
        ),
        WebUiSettings(
          context: context,
          enableZoom: true,
          enableExif: true,
          enableResize: true,
          boundary: CroppieBoundary(
            width: ((size.height > size.width ? size.width : size.height) * 0.5)
                .toInt(),
            height:
                ((size.height > size.width ? size.width : size.height) * 0.5)
                    .toInt(),
          ),
        ),
      ],
    );

    final imgF = cancelCropImageAndNotReturn ? File('') : imageFile;
    return croppedFile != null ? File(croppedFile.path) : imgF;
  } */

  ///
  static Size getSize(
    BuildContext context, {
    double aspectRatio = 0.5,
    double maxSize = 1.0,
    double offSetX = 0.0,
    double offSetY = 0.0,
  }) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double calculatedWidth;
    double calculatedHeight;
    if (width > height) {
      calculatedWidth = height * aspectRatio;
      calculatedHeight = height;
    } else {
      calculatedWidth = width;
      calculatedHeight = width / aspectRatio;
    }
    return Size(
      calculatedWidth * maxSize + offSetX,
      calculatedHeight * maxSize + offSetY,
    );
  }

  static Future<String?> getTextFromClipboard() async {
    final clip = await Clipboard.getData(Clipboard.kTextPlain);
    final text = clip?.text;
    return text;
  }

  ///
  static void clipboardData(
    String value, {
    String dialogMessage = 'Copiado al portapapeles',
    String errorMessage = 'Error',
    bool share = false,
    String? subject,
  }) {
    if (value.isNotEmpty) {
      debugPrint("Copiado: $value");

      Clipboard.setData(ClipboardData(text: value));
      toast(dialogMessage);
    } else {
      Utils.toast(errorMessage, backgroundColor: Colors.red);
    }
  }

  /// custom date from epoch
  static String epochToCustomFormate(
    Object? value, [
    String formate = 'dd-MM-yyyy - h:mm a',
  ]) {
    int epoch = 0;
    if (value is int) {
      epoch = value;
    } else if (value is DateTime) {
      epoch = value.millisecondsSinceEpoch ~/ 1000;
    } else if (value is String) {
      try {
        epoch = int.parse(value);
      } catch (_) {}
    } else {
      epoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    }
    final date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    var format = DateFormat(formate);
    var dateResult = format.format(date);

    return dateResult;
  }

  static Future<TimeOfDay?> showTime(
    BuildContext context, [
    TimeOfDay? initialTime,
  ]) async {
    final dd = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return dd;
  }

  static Future<DateTime?> showDate(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    DateTime? currentDate,
  }) async {
    final dd = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      currentDate: currentDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2023, 1, 1),
      lastDate: lastDate ?? DateTime(2100, 12, 31),
    );
    return dd;
  }

  ///
  /*   static Future<String?> scanPhoto() async {
    final value = await Get.toNamed(ScreenNames.qrScan.route);
    return value;
    // String photoScanResult = await scanner.scanPhoto();

    /* try {
      String? cameraScanResult = await scanner.scan();
      return cameraScanResult;
    } catch (_) {
      return null;
    } */
  } */

  static randomNumber([int max = 100]) {
    var rng = Random();
    final rrr = rng.nextInt(max);
    return rrr;
  }

  /* static Future<void> sendEmail({
    String subject = '',
    List<String> recipients = const [],
    List<String> cc = const [],
    List<String> bcc = const [],
    String body = '',
    List<String>? attachmentPaths,
    bool isHTML = false,
  }) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: recipients,
      cc: cc,
      bcc: bcc,
      attachmentPaths: attachmentPaths,
      isHTML: isHTML,
    );

    await FlutterEmailSender.send(email);
  } */

  // formate time hh:mm:ss
  static String formateTime({
    required int timeInSecond,
    bool showHours = false,
  }) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hh = (timeInSecond / 3600).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    String hour = hh.toString().length <= 1 ? "0$hh" : "$hh";

    if (showHours) return "$hour:$minute:$second";
    return "$minute:$second";
  }

  static Stream<int> countDownFrom(
    int n, [
    Duration duration = const Duration(seconds: 1),
  ]) async* {
    if (n > 0) {
      yield n;
      await Future.delayed(duration);
      yield* countDownFrom(n - 1);
    } else {
      yield 0;
    }
  }

  // generate random string
  static String generateRandomString(
    int longitud, {
    TypeRandomGenerator type = TypeRandomGenerator.mixed,
  }) {
    const regexMixed =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const regexOnlyCharacters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const regexOnlyNumber = '0123456789';
    final random = Random();
    String char = '';

    for (int i = 0; i < longitud; i++) {
      if (TypeRandomGenerator.mixed == type) {
        char += regexMixed[random.nextInt(regexMixed.length)];
      } else if (TypeRandomGenerator.onlyNumber == type) {
        char += regexOnlyNumber[random.nextInt(regexOnlyNumber.length)];
      } else {
        char += regexOnlyCharacters[random.nextInt(regexOnlyCharacters.length)];
      }
    }

    return char;
  }
}
