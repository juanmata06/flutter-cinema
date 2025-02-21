import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinema/presentation/provider/providers_exports.dart';
import 'package:flutter_cinema/presentation/widgets/widgets_exports.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final carouselMovies = ref.watch(moviesCarouselProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) {
          return Column(children: [
            MoviesCarousel(movies: carouselMovies),
            MoviesAndInfoCarousel(
                movies: nowPlayingMovies,
                title: 'In theaters',
                subtitle: 'Monday 17',
                loadNextPage: () =>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
              ),
            MoviesAndInfoCarousel(
                movies: upcomingMovies,
                title: 'Very soon',
                subtitle: 'Next month',
                loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
            MoviesAndInfoCarousel(
                movies: popularMovies,
                title: 'Most populars',
                // subtitle: '',
                loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),
            MoviesAndInfoCarousel(
                movies: topRatedMovies,
                title: 'Top rated',
                subtitle: 'TMDB',
                loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
              ),
            const SizedBox(height: 10),
          ]);
        }
      ))
    ]);
  }
}
