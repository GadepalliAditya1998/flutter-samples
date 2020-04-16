import 'dart:async';

abstract class IConnectivty {
  bool isConnected;

  Future<bool> checkConnectivity();

  Stream<bool> onConnectivityChange();

  void stopConnectivityUpdates();
}
