import "package:flutter/material.dart";
import "package:flutter_cinema/presentation/providers/providers_exports.dart";
import "package:flutter_cinema/presentation/widgets/widgets.exports.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class HomeScreen extends StatelessWidget {
  static const route = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyView(),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView();

  @override
  _BodyViewState createState() => _BodyViewState();
}

class _BodyViewState extends ConsumerState<_BodyView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMoviesMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMoviesMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: const CustomAppBar(),
                ),
              );
            },
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: slideShowMovies),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  labelTitle: 'En cines',
                  labelSubtitle: 'Lunes 17',
                  loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 25),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  labelTitle: 'Populares',
                  labelSubtitle: 'Solo Tops',
                  loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 25),
                MoviesHorizontalListview(
                  movies: upcomingMoviesMovies,
                  labelTitle: 'Próximamente',
                  labelSubtitle: 'Julio 1',
                  loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 25),
                MoviesHorizontalListview(
                  movies: topRatedMoviesMovies,
                  labelTitle: 'Mejor valoradas',
                  labelSubtitle: 'IMDb',
                  loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 50),
              ],
            );
          },
          childCount: 1
        ))
      ]
    );
  }
}
