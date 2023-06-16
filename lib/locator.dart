import "package:client/services/implementations/storage_service/main_storage_service.dart";
import 'package:client/services/implementations/utils_service.dart';
import 'package:client/services/interfaces/utils_service_interface.dart';
import "package:get_it/get_it.dart";

import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:client/services/implementations/storage_service/supabase_storage_service.dart';

final locator = GetIt.instance;

void getItSetup() {
  //locator.registerSingletonAsync<StorageService>(() async => SupabaseStorageService.create());
  locator.registerSingletonAsync<StorageServiceInterface>(() async =>
      MainStorageService.create(
          externalStorageService: await SupabaseStorageService.create()));

  locator.registerSingletonAsync<UtilsServiceInterface>(
      () async => UtilsService());
}
