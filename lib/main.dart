/*
 * FLauncher
 * Copyright (C) 2021  Étienne Fesser
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:async';

import 'package:flauncher/database.dart';
import 'package:flauncher/flauncher_channel.dart';
import 'package:flauncher/unsplash_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplash_client/unsplash_client.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'flauncher_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('starting app');
  Paint.enableDithering = true;
  WebView.platform = SurfaceAndroidWebView();

  final sharedPreferences = await SharedPreferences.getInstance();
  final imagePicker = ImagePicker();
  final fLauncherChannel = FLauncherChannel();
  final fLauncherDatabase = FLauncherDatabase.connect(connect());
  final unsplashService = UnsplashService(
    UnsplashClient(
      settings: ClientSettings(
        debug: kDebugMode,
        credentials: AppCredentials(
          accessKey: "",
          secretKey: "",
        ),
      ),
    ),
  );
  runApp(
    FLauncherApp(
      sharedPreferences,
      imagePicker,
      fLauncherChannel,
      fLauncherDatabase,
      unsplashService,
    ),
  );
}

// Future<FirebaseRemoteConfig> _initFirebaseRemoteConfig() async {
//   final remoteConfig = FirebaseRemoteConfig.instance;
//   await remoteConfig.setDefaults({
//     "unsplash_enabled": false,
//     "unsplash_access_key": "",
//     "unsplash_secret_key": ""
//   });
//   await remoteConfig.setConfigSettings(
//     RemoteConfigSettings(
//       fetchTimeout: Duration(minutes: 1),
//       minimumFetchInterval: kReleaseMode ? Duration(hours: 6) : Duration.zero,
//     ),
//   );
//   await remoteConfig.ensureInitialized().catchError((error, stackTrace) async {
//     if (!(error is FormatException && error.message == "Invalid envelope")) {
//       await FirebaseCrashlytics.instance.recordError(error, stackTrace);
//     }
//   });
//   remoteConfig.fetchAndActivate().catchError((error, stackTrace) async {
//     if (!(error is FormatException && error.message == "Invalid envelope")) {
//       await FirebaseCrashlytics.instance.recordError(error, stackTrace);
//     }
//     return false;
//   });
//
//   return remoteConfig;
// }
