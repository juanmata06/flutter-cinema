import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/presentation/provider/providers_exports.dart';
import 'package:flutter_cinema/presentation/delegates/search_movie_delegate.dart';
import 'package:go_router/go_router.dart';


class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.movie_outlined,
              color: colors.primary,
            ),
            const SizedBox(width: 5),
            Text('My movies', style: titleStyle),
            const Spacer(),
            IconButton(
              onPressed: () {
                final moviesProvider = ref.read(searchMoviesProvider);
                final searchProvider = ref.read(searchQueryProvider);
                
                showSearch<Movie?>(
                  query: searchProvider,
                  context: context, 
                  delegate: SearchMoviesDelegate(
                    initialMovies: moviesProvider,
                    callBack: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery
                  )
                ).then((movie) {
                  if(movie == null) return;
                  context.go('/home/0/movie/${movie.id}');
                });
              },
              icon: Icon(
                Icons.search,
                color: colors.primary,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
