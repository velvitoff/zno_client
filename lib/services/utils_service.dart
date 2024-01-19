import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UtilsService {
  static Map<String, String> keywordMap = {
    'zno': 'ЗНО',
    'nmt': 'НМТ',
    'dodatkova': 'Додаткова сесія',
    'testova': 'Тестова сесія',
    'osnovna': 'Основна сесія',
    'probna': 'Пробна сесія',
    'demo': 'Демоваріант',
    'spec': 'Спец сесія',
    'zrazok': 'Зразок завдань'
  };

  String fileNameToSessionName(String fileName) {
    fileName = fileName.replaceFirst('.json', '');
    fileName = fileName.replaceFirst('.bin', '');
    List<String> split = fileName.split('_');

    for (int i = 0; i < split.length; ++i) {
      split[i] = keywordMap[split[i]] ?? split[i];
    }
    return split.join(' ');
  }

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
