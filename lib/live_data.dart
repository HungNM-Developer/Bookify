import 'package:dio/dio.dart';

import 'src/settings/settings_controller.dart';

class LiveData {
  static String accessToken = '';
  static String userName = '';
  static String email = '';
  static String role = '';
  static late SettingsController settingsController;
  static Dio dio = Dio();
}
