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
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideShow(movies: slideShowMovies),
        MoviesHorizontalListview(
          movies: nowPlayingMovies,
          labelTitle: 'En cines',
          labelSubtitle: 'Lunes 15',
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
        )
      ],
    );
  }
}
