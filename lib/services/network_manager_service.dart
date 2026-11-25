import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkManagerService {
  final _connectionController = StreamController<bool>.broadcast();
  Stream<bool> get onStatusChange => _connectionController.stream;
  
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  late StreamSubscription<InternetStatus> _connectionListener;

  Future<void> init() async {
    // Initial check
    _isConnected = await InternetConnection().hasInternetAccess;
    _connectionController.add(_isConnected);

    _connectionListener = InternetConnection().onStatusChange.listen((InternetStatus status) {
      _isConnected = status == InternetStatus.connected;
      _connectionController.add(_isConnected);
    });
  }

  void dispose() {
    _connectionListener.cancel();
    _connectionController.close();
  }
}
