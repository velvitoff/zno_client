import 'package:client/dto/personal_config_data.dart';

abstract class PureLocalStorageServiceInterface {
  Future<PersonalConfigData> getPersonalConfigData();
  Future<void> savePersonalConfigData(PersonalConfigData data);
}
