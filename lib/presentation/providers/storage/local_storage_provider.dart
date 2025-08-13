import 'package:app_flutter_the_movie/infrastructure/datasources/local_storage_datasource_impl.dart';
import 'package:app_flutter_the_movie/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: HiveDatasource());
});






