import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DecryptionService {
  //throws
  String decryptBin(Uint8List data) {
    final keyString = dotenv.env['keyEncrypt'];
    if (keyString == null) {
      throw ();
    }
    final key = encrypt.Key.fromUtf8(keyString);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    final encryptedData = encrypt.Encrypted(data.sublist(16));
    final iv = encrypt.IV(data.sublist(0, 16));
    final res = encrypter.decrypt(encryptedData, iv: iv);
    return res;
  }
}
