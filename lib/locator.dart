import "package:client/services/implementations/storage_service/main_storage_service.dart";
import "package:get_it/get_it.dart";

import "package:client/services/interfaces/storage_service.dart";
import 'package:client/services/implementations/storage_service/supabase_storage_service.dart';

final locator = GetIt.instance;

void getItSetup() {
  //locator.registerSingletonAsync<StorageService>(() async => SupabaseStorageService.create());
  locator.registerSingletonAsync<StorageService>(() async => MainStorageService.create(
    externalStorageService: await SupabaseStorageService.create()
  ));
}