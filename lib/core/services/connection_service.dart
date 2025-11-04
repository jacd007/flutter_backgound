/* import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Example:
/// ```
/// void main() {
///   ConnectionService.listenToConnectionChanges();
///   runApp(MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: Scaffold(
///         body: StreamBuilder(
///           stream: ConnectionService.stream,
///           builder: (context, snapshot) {
///             if (snapshot.data == false) {
///               return Text('No Internet connection');
///             } else {
///               return Text('Established connection');
///             }
///           },
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
class ConnectionService {
  ConnectionService._();

  static final _controller = StreamController<bool>.broadcast();

  /// The stream of internet connection status.
  static Stream<bool> get stream => _controller.stream;

  /// Checks the internet connection status.
  ///
  /// This function performs a lookup on 'google.com' to determine if there is
  /// an active internet connection. It waits for 3 seconds before attempting
  /// the lookup to allow any network setups to complete. If the lookup is
  /// successful and returns a non-empty address, it adds `true` to the
  /// connection status stream indicating an established connection.
  /// Otherwise, it adds `false` indicating no connection. In the event of a
  /// `SocketException`, it also adds `false` to the stream indicating an error
  /// in connection.
  static Future<void> checkConnection() async {
    try {
      await Future.delayed(
        const Duration(seconds: 3),
      ); // Esperar a que se establezca la conexión
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        _controller.add(true); // Conexión establecida
      } else {
        _controller.add(false); // Sin conexión
      }
    } on SocketException catch (_) {
      _controller.add(false); // Sin conexión
    }
  }

  /// Listens for changes in the internet connection status.
  ///
  /// This function sets up a listener on the `Connectivity` event stream.
  /// When the connection status changes, it calls [checkConnection] to
  /// update the connection status stream.
  static void listenToConnectionChanges() {
    Connectivity().onConnectivityChanged.listen((_) {
      checkConnection();
    });
  }

  /// Checks if there is an active internet connection.
  ///
  /// This function waits for the provided [duration] before attempting to
  /// look up 'google.com'. If the lookup is successful and returns a
  /// non-empty address, it returns `true` indicating an established
  /// connection. Otherwise, it returns `false` indicating no connection.
  /// In the event of a `SocketException`, it also returns `false` indicating
  /// an error in connection.
  static Future<bool> checkIfThereIsConnection([
    Duration duration = const Duration(milliseconds: 1500),
  ]) async {
    try {
      await Future.delayed(duration);
      final result = await InternetAddress.lookup('google.com');
      bool check = result.every((e) => e.rawAddress.isNotEmpty);
      if (result.isNotEmpty && check) {
        return true;
      } else if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Closes the connection status stream controller when it is no longer needed.
  ///
  /// This should be called when the widget using this service is disposed.
  static Future<void> dispose() async {
    await _controller.close();
  }
}
 */
