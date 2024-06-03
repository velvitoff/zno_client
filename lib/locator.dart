import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/services/supabase_service.dart';
import 'package:client/services/decryption_service.dart';
import 'package:client/services/init_service.dart';
import 'package:client/services/testing_route_service.dart';
import "package:get_it/get_it.dart";

final locator = GetIt.instance;

void getItSetup() {
  locator.registerSingletonAsync<InitService>(
      () async => await InitService.init());

  locator.registerSingletonAsync<StorageService>(
      () async => StorageService.create(),
      dependsOn: [InitService]);

  locator.registerSingletonAsync<SupabaseService>(
      () async => const SupabaseService(),
      dependsOn: [InitService]);

  locator.registerSingletonAsync<DecryptionService>(
      () async => DecryptionService());

  locator.registerSingleton<DialogService>(const DialogService());
  locator.registerSingleton<TestingRouteService>(const TestingRouteService());
}
