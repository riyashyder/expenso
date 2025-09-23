import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class CryptoHelper {
  static const String SECRET_KEY = "kY7U1mo8LLX3LdKk7nAV4Kz6uYXSSc4KlR4If8iA2X4=";

  static Future<String?> getShopId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('shop_id');
  }

  Uint8List generateAESKey(String password) {
    return Uint8List.fromList(sha256.convert(utf8.encode(password)).bytes);
  }

  dynamic encryptAES(String plainText) {
    final key = Key(generateAESKey(SECRET_KEY));
    final iv = IV.fromLength(12);
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final encryptedBytes = encrypted.bytes;
    final tag = encryptedBytes.sublist(encryptedBytes.length - 16);
    final ciphertext = encryptedBytes.sublist(0, encryptedBytes.length - 16);
    return {
      "ciphertext": base64.encode(ciphertext),
      "iv": base64.encode(iv.bytes),
      "tag": base64.encode(tag),
    };
  }

  dynamic decryptAES(Map<String, dynamic> encryptedData) {
    try {
      final key = Key(generateAESKey(SECRET_KEY));
      final ivBytes = IV.fromBase64(encryptedData["iv"]);
      final encryptedBytes = base64.decode(encryptedData["ciphertext"]);
      final tagBytes = base64.decode(encryptedData["tag"]);
      final completeCiphertext = Uint8List.fromList([...encryptedBytes, ...tagBytes]);
      final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
      final decrypted = encrypter.decrypt(
        Encrypted(completeCiphertext),
        iv: ivBytes,
      );
      return jsonDecode(decrypted);
    } catch (e) {
      return " Decryption Failed: $e";
    }
  }
}