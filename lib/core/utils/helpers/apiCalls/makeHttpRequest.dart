import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../encryptDecrypt/encrypt_decrypt_helper.dart';
import '../file_helper.dart';
import '../../../../features/utils/get_context.dart';
import '../navigationScreens/logout_controller.dart';

class MakeHttpRequest {
  dynamic responseData = null;

  Future<dynamic> makeHttpRequest(
      dynamic method,
      String url,
      dynamic payload,
      Function(String) showSnackBarCallback, {
        bool isFormData = false,
      }) async {
    // print("Payload: $payload");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      String? token = prefs.getString('token');
      // developer.log(token.toString());

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        "x-key": "kY7U1mo8LLX3LdKk7nAV4Kz6uYXSSc4KlR4If8iA2X4=",
        'user-agent': 'mobile'
      };
      final Uri uri = Uri.parse(url);
      print('\x1B[32mURL : $uri\x1B[0m');
      if (isFormData) {
        var request = http.MultipartRequest("PATCH", uri);
        request.headers.addAll(headers);

        if (payload["file"] != null) {
          File file;

          if (payload["file"].startsWith("assets/")) {
            file = await FileHelper.getFileFromAssets(payload["file"]);
          } else {
            file = File(payload["file"]);
          }

          if (file.existsSync()) {
            String? mimeType = lookupMimeType(file.path) ?? "image/png";

            request.files.add(
              await http.MultipartFile.fromPath(
                "file",
                file.path,
                contentType: MediaType.parse(mimeType),
              ),
            );
          } else {
            print("Error: File does not exist at path ${file.path}");
            return {"error": "File not found"};
          }
        }

        dynamic requestPayload = {};
        payload.forEach((key, value) {
          if (key != "file") requestPayload[key] = value.toString();
        });

        request.fields["data"] = json.encode(CryptoHelper().encryptAES(json.encode(requestPayload)));

        var streamedResponse = await request.send();
        responseData = json.decode((await http.Response.fromStream(streamedResponse)).body);

        if (responseData['success']) {
          dynamic decryptedResponse = jsonDecode(CryptoHelper().decryptAES(responseData['data']));

          responseData = {
            "data": decryptedResponse,
            "code": responseData['code'],
            "success": responseData['success'],
            "message": responseData?['message'],
          };
        } else {
          print("Handle Error");
        }
        return responseData;
      } else {
        print("123");
        // Encrypt payload if it's not null
        dynamic encryptedPayload;
        if (payload != null) {
          encryptedPayload = CryptoHelper().encryptAES(json.encode(payload));
        }
        print(192);
        print('the encrypted payload :$encryptedPayload');
        final response = (payload == null)
            ? await method(uri, headers: headers).timeout(Duration(seconds: 15)) // GET request
            : await method(uri, headers: headers, body: json.encode({'data': encryptedPayload}))
            .timeout(Duration(seconds: 20)); // POST/PUT request

        if (response?.body == null) {
          // print("response------->");
          print(response);

          return;
        }

        dynamic decodedResponse = json.decode(response.body);

        if (decodedResponse['error'] != null &&
            decodedResponse['error']['message'] ==
                'Your session seems to have either expired or is invalid. Please log in again.') {
          AuthServiceLogout().logout(AppContext.context, sessionExpired: true);
          throw Exception('Session Expired');
        }

        // print("180");
        // print("decodedResponse");
        // print(decodedResponse);
        if (decodedResponse['data'] is Map<String, dynamic>) {
          dynamic decryptedResponse = jsonDecode(CryptoHelper().decryptAES(decodedResponse['data']));
          responseData = {
            "data": decryptedResponse,
            "code": decodedResponse['code'],
            "success": decodedResponse['success']
          };
          print("Response-Data");
          print(decryptedResponse);
          // print(responseData); // Convert decrypted string back to Map
        } else {
          responseData = decodedResponse; // It's already a Map, so assign it directly
        }
        print('Response : ${responseData.toString()}');
        return responseData;
      }
    } catch (error) {
      // print('Error in HTTP request: $error');
      responseData = error;
      return error;
    } finally {
      if (responseData is Map && responseData['error']?['code'] == 401) {
        // Handle logout
      }

      if (responseData is Map && (responseData?['message'] != null || responseData['error']?['message'] != null)) {
        showSnackBarCallback(responseData?['message'] ?? responseData?['error']?['message']);
      }
    }
  }
}