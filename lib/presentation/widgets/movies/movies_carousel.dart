import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter_cinema/domain/entities/movie.dart';

class MoviesCarousel extends StatelessWidget {
  final List<Movie> movies;
  const MoviesCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.8,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _MovieCarouselcard(movie: movies[index]),
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary, color: colors.secondary)
        ),
      ),
    );
  }
}

class _MovieCarouselcard extends StatelessWidget {
  final Movie movie;

  const _MovieCarouselcard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(0, 10)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12));
                }
                return FadeIn(child: child);
              },
            )
        )
      ),
    );
  }
}