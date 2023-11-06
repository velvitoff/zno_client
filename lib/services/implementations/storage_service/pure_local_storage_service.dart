import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;
import 'package:client/dto/personal_config_data.dart';
import 'package:client/services/interfaces/pure_local_storage_service_interface.dart';

class PureLocalStorageService implements PureLocalStorageServiceInterface {
  final Directory _appDir;

  PureLocalStorageService._create(Directory appDirectory)
      : _appDir = appDirectory;

  static Future<PureLocalStorageService> create() async {
    return PureLocalStorageService._create(
        await path.getApplicationDocumentsDirectory());
  }

  String get _znoDirPath =>
      '${_appDir.path}${Platform.pathSeparator}zno_client';

  @override
  Future<PersonalConfigData> getPersonalConfigData() async {
    final file =
        File('$_znoDirPath${Platform.pathSeparator}personal_config.json');
    if (!await file.exists()) {
      return PersonalConfigData.getDefault();
    }

    final data = await file.readAsString();
    return PersonalConfigData.fromJSON(jsonDecode(data));
  }

  @override
  Future<void> savePersonalConfigData(PersonalConfigData data) async {
    final file =
        await File('$_znoDirPath${Platform.pathSeparator}personal_config.json')
            .create(recursive: true);
    await file.writeAsString(jsonEncode(data.toJSON()));
  }
}
