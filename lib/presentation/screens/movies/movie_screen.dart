import 'package:flutter/material.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter_cinema/presentation/providers/providers_exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if(movie == null){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2)
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) =>_MovieDetails(movie: movie),
            childCount: 1
          ))
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, //* 70% de la medida del dispositivo:
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            //* Imagen:
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            //* Gradiente para la imagen:
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0], //* Empieza en el 70% hasta el 100%
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ]
                    )
                )
                ),
            ),
            //* Gradiente para el < :
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3], //* Empieza en el 0% hasta el 40%
                    colors: [
                      Colors.black,
                      Colors.transparent
                    ]
                    )
                )
                ),
            )

          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // //* Poster en pequeño
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Image.network(
              //     movie.posterPath,
              //     width: size.width * 0.3,
              //   ),
              // ),
              //* Descripción
              SizedBox(
                width: size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      movie.title, 
                      style: textStyles.titleLarge
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.overview, 
                      style: textStyles.bodyMedium,
                      textAlign: TextAlign.center
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        //* Generos de película
        Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(
                    gender, 
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ))
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ActorsByMovieSlider(movieId: movie.id.toString()),
        const SizedBox(height: 1000),
      ],
    );
  }
}

class _ActorsByMovieSlider extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovieSlider({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if(actorsByMovie[movieId] == null){
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    return Placeholder();
  }
}