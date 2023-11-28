import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() => _instance;

  NetworkManager._internal();

  final Connectivity _connectivity = Connectivity();
  bool _isConnected = false; // Initialize with a default value

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initialize() async {
    _isConnected = await checkConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = (result != ConnectivityResult.none);
    });
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }

  Future<bool> checkConnectivity() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    return (result != ConnectivityResult.none);
  }

  bool get isConnected => _isConnected;
}
