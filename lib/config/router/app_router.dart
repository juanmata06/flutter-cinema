import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens_exports.dart';

final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) => MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
        ),
      ]
    )
  ]
);
