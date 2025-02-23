import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter_cinema/domain/entities/movie.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMoviesDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack callBack;

  SearchMoviesDelegate({required this.callBack});

  @override
  String get searchFieldLabel => 'Search movies';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: callBack(query), 
      builder: (context, snapshot){
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: close,
          ),
        );
      }
    );
  }
}



class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row( 
          children: [
            SizedBox(
              width: deviceSize.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(
                    child: child
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: deviceSize.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100) ?
                    Text('${movie.overview.substring(0, 100)}...') :
                    Text(movie.overview),
                  Row(children: [
                    const Icon(Icons.star_half_rounded, color: Colors.amber),
                    const SizedBox(width: 5),
                    Text(movie.voteAverage.toStringAsFixed(1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                  ])
                ],
              ),
            )
        ]),
      ),
    );
  }
}
