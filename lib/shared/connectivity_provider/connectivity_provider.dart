import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as developer;

import '../widgets/styles/styles.dart';



class ConnectivityProvider extends ChangeNotifier {
  bool _isConnected = true; // Assume connected at start
  bool get isConnected => _isConnected;

  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  // final local = getLocalizationController(AppContext.context);

  ConnectivityProvider() {
    checkConnectivity();
    _listenToConnectivityChanges();
  }
  bool isloading = true;

  void checkConnectivity() async {
    developer.log('1 checking connection');
    isloading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (result.isNotEmpty) {
      _updateConnectionStatus(result.first);
    }
    developer.log('2 cnnection checked');
    isloading = false;
    notifyListeners();
  }

  void _listenToConnectivityChanges() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.isNotEmpty) {
        _updateConnectionStatus(result.first);
      }
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    developer.log('3 updating connection');
    bool newConnectionStatus = result != ConnectivityResult.none;
    if (_isConnected != newConnectionStatus) {
      _isConnected = newConnectionStatus;
      notifyListeners();
      _showConnectivitySnackbar();
    }
  }

  void _showConnectivitySnackbar() {
    ScaffoldMessenger.of(RappContext.context).showSnackBar(
      SnackBar(
        content: Text(
          _isConnected ? Rtext.netConnected : Rtext.networklost,
          style: AppthemeData.teambtns,
        ),
        backgroundColor: _isConnected ? Colors.green : Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }




}


class Rtext {
  Rtext._();

  //constant text that can be used in app
  static const networklost = '"Offline",Connect to a network';
  static const netConnected = "Back online! You’re connected.";
}


class RappContext {
  RappContext._();

  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorkey.currentState!.context;
}
