import "package:flutter_cinema/screens/movies/home_screen.dart";
import "package:go_router/go_router.dart";

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.route,
      builder: (context, state) => const HomeScreen(),
    )
  ]
);