/* import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class UrlLauncherUtils {
  static Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInWebViewOrVC(String url,
      {Map<String, String>? headers}) async {
    String textUrl = url;

    // conditional
    if (!textUrl.startsWith("http")) textUrl = 'https://$textUrl';

    final kHeaders = headers ?? const <String, String>{};

    if (!await launchUrl(
      Uri.parse(textUrl),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: WebViewConfiguration(headers: kHeaders),
    )) {
      throw 'Could not launch $textUrl';
    }
  }

  static Future<void> launchInWebViewWithoutJavaScript(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInWebViewWithoutDomStorage(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchUniversalLinkIos(String url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  static launchPhone(String phone) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Uri.parse('tel://$phone'),
    );

    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Uri.parse('tel://$phone'),
      );
    }
  }

/*   static String _ss({required String phone, String message = ''}) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }
 */

  /// String [phone] = "+10123456789";
  ///
  /// String url = "https://api.whatsapp.com/send?phone=$phone";
  ///
  /// Uri uri = Uri.parse(url);
  ///
  ///  bool nativeAppLaunchSucceeded = await launchUrl(uri);
  /// is true Open launch url
  static launchWhatsapp(String phone, [String? message]) async {
    //  https://wa.me/
    //  https://api.whatsapp.com/send?phone=
    final msg = message != null ? '?text=$message' : '';

    final url = 'https://wa.me/$phone$msg';
    debugPrint(url);

    final bool hasLaunch = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );

    if (!hasLaunch) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } /* else {
      Utils.toast(
          'Enlace incorrecto. Cierra la venta y vuelve a intentarlo con un enlace diferente.');
    } */
  }

  static launchWhatsApp2(String phone, [String? message]) async {
    final link = WhatsAppUnilink(
      phoneNumber: phone,
      text: message,
    );
    await launchUrl(link.asUri());
  }

  static launchEmail(
      {required String email,
      required String subject,
      required String body}) async {
    final url =
        'mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Uri.parse(url),
    );

    if (!nativeAppLaunchSucceeded) {
      await launchUrl(Uri.parse(url));
    }
  }

  static launchSMS(String numberPhone, String message) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: numberPhone, //'0118 999 881 999 119 7253',
      queryParameters: <String, String>{
        //'body': Uri.encodeComponent(message),
        'body': message,
      },
    );

    final bool valid = await launchUrl(smsLaunchUri);

    if (!valid) {
      await launchUrl(smsLaunchUri);
    }
  }
}
 */
