import 'dart:typed_data';

abstract class UtilsServiceInterface {
  String fileNameToSessionName(String fileName);
  String decryptBin(Uint8List data);
}
