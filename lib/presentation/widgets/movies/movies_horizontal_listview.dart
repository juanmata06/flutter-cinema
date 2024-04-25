import "package:animate_do/animate_do.dart";
import "package:flutter/material.dart";
import "package:flutter_cinema/config/helpers/human_formats.dart";
import "package:flutter_cinema/domain/entities/movie.dart";

class MoviesHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? labelTitle;
  final String? labelSubtitle;
  final VoidCallbackAction? loadNextPage;

  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.labelTitle,
      this.labelSubtitle,
      this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          // Label del list view:
          if (labelTitle != null || labelSubtitle != null)
            _Label(title: labelTitle, subtitle: labelSubtitle),
          // Contenedor del list view:
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: movies[index]);
              },
            )
          )
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Label({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subTitleStyle = Theme.of(context).textTheme.bodySmall;

    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(
                  subtitle!,
                  style: subTitleStyle,
                ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //* Card container
        SizedBox(
          width: 150,
          child: 
          //* Card 
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              width: 150,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }

                return FadeIn(child: child);
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        //* Bottom card title
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            maxLines: 1,
            style: textStyles.titleSmall,
          ),
        ),
        //* Bottom card movie rating
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 3),
              Text('${ movie.voteAverage }', style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
              const Spacer(),
              Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall),
            ]
          ),
        )
      ]),
    );
  }
}
