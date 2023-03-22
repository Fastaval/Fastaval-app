import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> askForTrackingPermission(BuildContext context) async {
  final TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status == TrackingStatus.notDetermined) {
    await showCustomTrackingDialog(context);
    await Future.delayed(const Duration(milliseconds: 200));
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

showCustomTrackingDialog(BuildContext context) async => await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dear User'),
        content: const Text(
          'We care about your privacy and data security. We keep this app free by showing ads. '
          'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
          'Our partners will collect data and use a unique identifier on your device to show you ads.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
