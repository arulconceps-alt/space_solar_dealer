import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkListener extends StatefulWidget {
  final Widget child;

  const NetworkListener({
    super.key,
    required this.child,
  });

  @override
  State<NetworkListener> createState() =>
      _NetworkListenerState();
}

class _NetworkListenerState
    extends State<NetworkListener> {
  late StreamSubscription<List<ConnectivityResult>>
  _subscription;

  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();

    _checkInternet();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((result) {
      final hasNoInternet =
      result.contains(
        ConnectivityResult.none,
      );

      if (hasNoInternet) {
        _showNoInternetDialog();
      } else {
        _closeDialog();
      }
    });
  }

  Future<void> _checkInternet() async {
    final result =
    await Connectivity()
        .checkConnectivity();

    final hasNoInternet =
    result.contains(
      ConnectivityResult.none,
    );

    if (hasNoInternet) {
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "No Internet",
          ),
          content: const Text(
            "Please turn on mobile data or WiFi.",
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _closeDialog() {
    if (_isDialogShowing) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();

      _isDialogShowing = false;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}