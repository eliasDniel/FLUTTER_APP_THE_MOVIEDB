



import 'package:app_flutter_the_movie/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/repositories/moviedb_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MoviedbRepositoryImpl( MoviedbDatasource() );
});