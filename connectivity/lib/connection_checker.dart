import 'dart:async';
import 'dart:io';

import 'package:connectivity/IConnectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class ConnectionChecker implements IConnectivty {
  @override
  bool isConnected;

  DataConnectionChecker _connectionChecker = DataConnectionChecker();

  StreamController<bool> _connectionStreamController;

  StreamSubscription<DataConnectionStatus> _connectionStatusListener;

  @override
  Future<bool> checkConnectivity() {
    return _connectionChecker.hasConnection;
  }

  @override
  Stream<bool> onConnectivityChange() {
    _connectionStreamController = StreamController<bool>();
    _configConnection();

    _connectionStatusListener =
        _connectionChecker.onStatusChange.listen((status) {
      isConnected = (status == DataConnectionStatus.connected);
      _connectionStreamController.add(isConnected);
    });

    return _connectionStreamController.stream;
  }

  void _configConnection() {
    _connectionChecker.addresses = [
      AddressCheckOptions(
        InternetAddress('1.1.1.1'),
      ),
    ];
  }

  @override
  void stopConnectivityUpdates() {
    if (_connectionStatusListener != null) {
      _connectionStatusListener.cancel();
    }

    if (_connectionStreamController != null)
      _connectionStreamController.close();
  }
}
