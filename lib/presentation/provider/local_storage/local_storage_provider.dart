import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cinema/infrastructure/datasources/isar_local_storage_datasource.dart';
import 'package:flutter_cinema/infrastructure/repositories/local_storage_repositorie_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositorieImpl(dataSource: IsarLocalStorageDatasource());
});