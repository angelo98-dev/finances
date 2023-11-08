import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Runs the [App] with the specified [config]
// TODO(Yannick): add config
Future<void> run({
  //required Config config
  required Widget app,
}) async =>
    runZonedGuarded(
      () async => runApp(
        ProviderScope(
          child: app,
        ),
      ),
      (error, stack) {
        log('Error : $error  - Stack : $stack');
      },
    );
