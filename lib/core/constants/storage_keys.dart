// lib/core/constants/storage_keys.dart
// ignore_for_file: constant_identifier_names

class StorageKeys {
  StorageKeys._();

  /// It is used to check if the user has an active session or not.
  static const String isLogin = 'sharedIsLogin';

  /// If the endpoints contain token security, it is stored with this key
  static const String jwt = 'sharedJWT';

  /// If the application needs to save the selected theme, this key is used
  static const String theme = 'sharedTheme';

  /// When the application contains an introduction screen, this is used to
  /// show or omit it
  static const String hideInto = 'sharedHideInto';

  /// This key is used to save the email after logging in
  static const String email = 'sharedEmail';

  /// Since all users who log in have an ID, this key is used to save it
  static const String dniPerson = 'sharedDniPerson';

  /// Since all users who log in have an TypeUser, this key is used to save it
  static const String typePerson = 'sharedTypePerson';

  /// Since all users who logo have a company associated with an ID, this key
  /// is used to save it
  static const String idCompany = 'sharedIdCompany';

  /// If the application needs a code generated for each user, this variable
  /// is used to store it
  static const String codeUrl = 'sharedCodeUrl';

  /// Firebase's Token
  static const String firebaseToken = 'sharedFirebaseToken';

  /// milliseconds Since Epoch
  static const String tokenExpiration = 'sharedTokenExpiration';

  /// Data user to offline mode
  static const String dataUser = 'sharedDataUser';

  /// Data company to offline mode
  static const String dataCompany = 'sharedDataCompany';

  /// Background service persistent toggle
  static const String bgServiceEnabled = 'sharedBgServiceEnabled';

  /// Server URL to send GPS positions
  static const String bgServiceUrl = 'sharedBgServiceUrl';
}
