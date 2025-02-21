import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final provider1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final provider2 = ref.watch(upcomingMoviesProvider).isEmpty;
  final provider3 = ref.watch(popularMoviesProvider).isEmpty;
  final provider4 = ref.watch(topRatedMoviesProvider).isEmpty;

  if (provider1 || provider2 || provider3 || provider4) return true;

  return false;
});
