import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_cinema/config/helpers/human_formats.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';

class MoviesAndInfoCarousel extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MoviesAndInfoCarousel({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle, 
    this.loadNextPage
  });

  @override
  State<MoviesAndInfoCarousel> createState() => _MoviesAndInfoCarouselState();
}

class _MoviesAndInfoCarouselState extends State<MoviesAndInfoCarousel> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;

      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }

    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(children: [
        _TitleAndSubTitle(title: widget.title, subtitle: widget.subtitle,),
        Expanded(child: ListView.builder(
          controller: scrollController,
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return FadeInRight(child: _MoviesCarousel(movie: widget.movies[index]));
          },
        )
        )
      ]),
    );
  }
}

class _MoviesCarousel extends StatelessWidget {

  final Movie movie;
  const _MoviesCarousel({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Movie image:
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress){
                  if(loadingProgress != null){
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2)
                      ),
                    );
                  }
                  return GestureDetector(
                    child: FadeIn(child: child),
                    onTap: () => context.go('/movie/${movie.id}'),
                  );
                },
              ),
            ),
          ),
          //* Movie title:
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 1,
              style: textStyles.titleSmall,
            ),
          ),
          //* Movie rating:
          SizedBox(
            width: 150,
            child: Row(children: [
              const Icon(Icons.star_half_rounded, color: Colors.amber),
              const SizedBox(height: 3),
              Text(movie.voteAverage.toStringAsFixed(1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
              // const SizedBox(height: 3),
              const Spacer(),
              Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall),
            ]),
          ),
        ]
      ),
    );
  }
}

class _TitleAndSubTitle extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _TitleAndSubTitle({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
            Text(title!, style: textStyles.titleLarge),
          const Spacer(),
          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subtitle!,)
            )
        ],

      ),
    );
  }
}
