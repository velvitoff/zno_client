import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:client/services/interfaces/utils_service_interface.dart';

class UtilsService implements UtilsServiceInterface {
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

  @override
  String fileNameToSessionName(String fileName) {
    fileName = fileName.replaceFirst('.json', '');
    fileName = fileName.replaceFirst('.bin', '');
    List<String> split = fileName.split('_');

    for (int i = 0; i < split.length; ++i) {
      split[i] = keywordMap[split[i]] ?? split[i];
    }
    return split.join(' ');
  }

  @override
  String decryptBin(Uint8List data) {
    final key = encrypt.Key.fromUtf8(String.fromCharCodes([
      126,
      208,
      7,
      74,
      135,
      173,
      64,
      215,
      90,
      178,
      152,
      161,
      165,
      55,
      29,
      127
    ]));
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    final encryptedData = encrypt.Encrypted(data.sublist(16));
    final iv = encrypt.IV(data.sublist(0, 16));
    return encrypter.decrypt(encryptedData, iv: iv);
  }
}
