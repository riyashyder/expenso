
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api_constants.dart';
import '../apiCalls/makeHttpRequest.dart';

class AuthServiceLogout {
  static String logoutUrl = '${ApiConstants.devBaseUrl}/logout';

  final MakeHttpRequest _httpRequest = MakeHttpRequest();

  Future<void> clearFields(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (context.mounted) {}
  }

  Future<void> logout(BuildContext context,
      {bool sessionExpired = false}) async {


  }
}
