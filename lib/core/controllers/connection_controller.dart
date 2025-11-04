/* import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class ConnectionController extends GetxController {
  /// Observable variable to track internet connection status.
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((_) {
      checkConnection();
    });
  }

  /// Checks the internet connection status.
  ///
  /// This function performs a lookup on 'google.com' after a specified
  /// [Duration] to determine if there is an active internet connection. It
  /// waits for the specified duration before attempting the lookup to allow
  /// any network setups to complete. If the lookup is successful and returns a
  /// non-empty address, it adds `true` to the connection status stream
  /// indicating an established connection. Otherwise, it adds `false`
  /// indicating no connection. In the event of a `SocketException`, it also
  /// adds `false` to the stream indicating an error in connection.
  ///
  /// Returns `true` if internet connection is available, `false` otherwise.
  ///
  Future<bool> checkConnection(
      [Duration duration = const Duration(seconds: 2)]) async {
    try {
      await Future.delayed(duration);
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        isConnected.value = true;
      } else {
        isConnected.value = false;
      }
      update();
      return isConnected.value;
    } on SocketException catch (_) {
      isConnected.value = false;
      update();
      return false;
    }
  }
}
 */
