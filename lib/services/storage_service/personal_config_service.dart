import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;
import 'package:client/dto/personal_config_data.dart';

class PersonalConfigService {
  final Directory _appDir;

  PersonalConfigService._create(Directory appDirectory)
      : _appDir = appDirectory;

  static Future<PersonalConfigService> create() async {
    return PersonalConfigService._create(
        await path.getApplicationDocumentsDirectory());
  }

  String get _znoDirPath =>
      '${_appDir.path}${Platform.pathSeparator}zno_client';

  Future<PersonalConfigData> getPersonalConfigData() async {
    final file =
        File('$_znoDirPath${Platform.pathSeparator}personal_config.json');
    if (!await file.exists()) {
      return PersonalConfigData.getDefault();
    }

    final data = await file.readAsString();
    return PersonalConfigData.fromJSON(jsonDecode(data));
  }

  Future<void> savePersonalConfigData(PersonalConfigData data) async {
    final file =
        await File('$_znoDirPath${Platform.pathSeparator}personal_config.json')
            .create(recursive: true);
    await file.writeAsString(jsonEncode(data.toJSON()));
  }
}
