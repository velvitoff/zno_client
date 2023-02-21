import "package:get_it/get_it.dart";

import "package:client/services/interfaces/storage_service.dart";
import "package:client/services/implementations/supabase_storage_service.dart";

final locator = GetIt.instance;

void getItSetup() {
  locator.registerSingletonAsync<StorageService>(() async => SupabaseStorageService.create());
}