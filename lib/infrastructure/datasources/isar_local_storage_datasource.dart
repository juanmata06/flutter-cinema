import 'package:isar/isar.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/domain/datasources/local_storage_datasource.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalStorageDatasource extends LocalStorageDataSource {

  late Future<Isar> localDB;

  IsarLocalStorageDatasource(){
    localDB = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if(Isar.instanceNames.isEmpty){
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieInFavorites(int movieId) async {
    final db = await localDB;
    final Movie? movie = await db.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();
    return movie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final db = await localDB;
    return db.movies
      .where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }

  @override
  Future<void> toggleAsFavorite(Movie movie) async {
    final db = await localDB;

    //* Buscamos la pelicula a partir de su id y la guardamos
    final favoriteMovie = await db.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    //* Eliminamos la pelicula si es que existe
    if(favoriteMovie != null){
      db.writeTxnSync(() => db.movies.deleteSync(favoriteMovie.isarId));
      return;
    }

    //* La agregamos a la bbdd sino
    db.writeTxnSync(() => db.movies.putSync(movie));
  }

}
