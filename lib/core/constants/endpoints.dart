enum EmvType { dev, qa, prod }

class UrlCore {
  UrlCore._();

  static final EmvType envType = EmvType.prod;

  static final String urlBase = switch (envType) {
    EmvType.dev => "https://xxxxxxxxxxxxxxxxxxxxx",
    EmvType.qa => "https://xxxxxxxxxxxxxxxxxxxxx",
    EmvType.prod => "https://xxxxxxxxxxxxxxxxxxxxx",
  };

  static const bool debugMode = true;

 /* static const String urlBase =
      debugMode
          ? "https://xxxxxxxxxxxxxxxxxxxxx"
          : "https://xxxxxxxxxxxxxxxxxxxxx"; */

  static const String urlBaseFirebase = "";

  /// privacy politics
  static const String linkPrivacy = "";

  /// link support help
  static const String linkHelp = "";

  /// link main Shop
  static const String linkShop = "";

  /// link Socket
  static String urlSocket(String token) => '$urlBase?x-token=$token';
  // String urlSocket(String token) => '$urlBase?token=$token';

  /// uri google
  static final Uri uriGoogle = Uri.parse('https://google.com');

  /// url webview from "Herramientas Virtuales"
  static final String urlHV = 'https://www.herramientasvirtuales.com';
}

// ...

class Endpoint {
  Endpoint._();

  // endpoint login safe token firebase
  static const String jsonLogin = "loginProject.json";

  /// endpoint get token to authorization
  static const String tokenLogin = '/token';

  /// endpoint get ????
  static const String card = '/card';

  /// endpoint login to Get search User, required [token]
  static const String searchUser = '/searchUser';

  /// endpoint login to create user, required [token]
  static const String register = '/auth/create';

  /// endpoint login to Get company, required [token]
  static const String company = '/api/v1/app/company';

  /// endpoint send code temporal to user email, required [token]
  static const String codeTemporal = '/api/v1/app/reset';

  /// endpoint login to create user, required [token]
  static const String imageUser = '/imageUser';

  /// endpoint list templates, required [token]
  static const String templates = '/api/v1/app/template';
}
