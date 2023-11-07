import 'package:client/services/implementations/auth_service.dart';
import "package:client/services/implementations/storage_service/main_storage_service.dart";
import 'package:client/services/implementations/storage_service/pure_local_storage_service.dart';
import 'package:client/services/implementations/supabase_service.dart';
import 'package:client/services/implementations/utils_service.dart';
import 'package:client/services/init_service.dart';
import 'package:client/services/interfaces/pure_local_storage_service_interface.dart';
import 'package:client/services/interfaces/utils_service_interface.dart';
import "package:get_it/get_it.dart";

import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:client/services/implementations/storage_service/supabase_storage_service.dart';

final locator = GetIt.instance;

void getItSetup() {
  locator.registerSingletonAsync<PureLocalStorageServiceInterface>(
      () => PureLocalStorageService.create());

  locator.registerSingletonAsync<InitService>(
      () async => await InitService.init());

  locator.registerSingletonAsync<StorageServiceInterface>(() async =>
      MainStorageService.create(
          externalStorageService: SupabaseStorageService()));

  locator.registerSingletonAsync<UtilsServiceInterface>(
      () async => UtilsService());

  locator.registerSingleton<AuthService>(const AuthService());
  locator.registerSingleton<SupabaseService>(const SupabaseService());
}
