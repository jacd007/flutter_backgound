import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en.dart';
import 'es.dart';

/// Clase encargada de la configuración de idiomas de la aplicación.
class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'es_ES': Es().messages,
    'en_US': En().messages,
  };

  /// default en-US
  static get fallbackLocale => const Locale('en', 'US');
}

const fallbackLocale = Locale('en', 'US');

const supportedLocales = [Locale("en"), Locale("es", "ES")];

// ***************************************************************************

/// [Tk] class to translations
///
/// Contain `String` keys
///
/// To place parameter, place the name of the parameter with the @ symbol,
/// then to replace this field use the .trParam method with the Map with the
/// same name as previously.
/// ```
/// {
///   'list': "@param list",
///   'count':"count: @number"
/// }
///
/// ...
///
/// var text = 'list'.trParam({"param": "Validate"});
/// print(text); // output: "Validate list"
///
/// var text2 = 'count'.trParam({"number": 50});
/// print(text2); // output: "count: 50"
///
/// ```
///
/// For plural of a word or phrase use the same noun ending in "Plural".
/// Example: "list" in singular and "listPlural" in plural together with its correct
/// writing in singular and plural.
///
/// ```
/// {
///   'list': "list",
///   'listPlural':"lists"
/// }
///
/// ...
///
/// var text = 'list'.trPlural('listPlural', 1);
/// print(text); // output: "list"
///
/// var text2 = 'list'.trPlural('listPlural', 2);
/// print(text2); // output: "lists"
/// ```
///
class Tk {
  static const String locale = 'locale';
  static const String languageCode = 'languageCode';
  static const String countryCode = 'countryCode';
  static const String titleApp = 'titleApp';

  // =========================== Basics ===========================
  static const String accept = 'accept';
  static const String cancel = 'cancel';
  static const String send = 'send';
  static const String save = 'save';
  static const String delete = 'delete';
  static const String forget = 'forget';
  static const String edit = 'edit';
  static const String notify = 'notify';
  static const String toastTitleExit = 'toastTitleExit';
  static const String toastMsgExit = 'toastMsgExit';
  static const String pageError = 'pageError';
  static const String noConnection = 'noConnection';
  static const String update = 'update';
  static const String pageMsgErrorInit = 'pageMsgErrorInit';
  static const String fieldNotEmpty = 'fieldNotEmpty';
  static const String deleteItem = 'deleteItem';
  static const String titleDeleteItem = 'titleDeleteItem';
  static const String policy = 'policy';
  static const String pageMsgError2 = 'pageMsgError2';
  static const String logout = 'logout';
  static const String choiceOption = 'choiceOption';

  static const String tMenu1 = "menu1";
  static const String tMenu2 = "menu2";
  static const String tMenu3 = "menu3";
  static const String tMenu4 = "menu4";
  static const String tMenu5 = "menu5";
}
