import "package:flutter_cinema/presentation/screens/movies/home_screen.dart";
import "package:flutter_cinema/presentation/screens/movies/movie_screen.dart";
import "package:go_router/go_router.dart";

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.route,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            return MovieScreen(movieId: state.pathParameters['id'] ?? '0');
          },
        )
      ]
    ),
    
  ]
);