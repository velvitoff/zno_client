import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service/local_storage_service.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/services/supabase_service.dart';
import 'package:client/services/utils_service.dart';
import 'package:client/services/init_service.dart';
import "package:get_it/get_it.dart";
import 'package:client/services/storage_service/supabase_storage_service.dart';

final locator = GetIt.instance;

void getItSetup() {
  locator.registerSingletonAsync<InitService>(
      () async => await InitService.init());

  locator.registerSingletonAsync<LocalStorageService>(
      () async => LocalStorageService.create());
  locator.registerSingleton<SupabaseStorageService>(SupabaseStorageService());
  locator.registerSingletonAsync<MainStorageService>(
      () async => MainStorageService(),
      dependsOn: [LocalStorageService]);

  locator.registerSingletonAsync<UtilsService>(() async => UtilsService());

  locator.registerSingleton<SupabaseService>(const SupabaseService());
  locator.registerSingleton<DialogService>(const DialogService());
}
