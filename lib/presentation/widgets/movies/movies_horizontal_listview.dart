import "package:flutter/material.dart";
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
          if (labelTitle != null || labelSubtitle != null)
            _Label(title: labelTitle, subtitle: labelSubtitle)
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
      padding: const EdgeInsets.only(top: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) 
            Text(title!, style: titleStyle,),
          const Spacer(),
          if (subtitle != null) 
            // Text(subtitle!, style: subTitleStyle)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subtitle!, style: subTitleStyle,)
            )
        ],
      ),
    );
  }
}

// class name extends StatelessWidget {
//   const name({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }