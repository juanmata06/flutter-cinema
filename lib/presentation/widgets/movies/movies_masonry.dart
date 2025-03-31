import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_cinema/domain/entities/movie.dart';
import 'package:flutter_cinema/presentation/widgets/widgets_exports.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> movieList;
  final VoidCallback? loadNextPage;

  const MoviesMasonry({
    super.key, 
    required this.movieList,
    this.loadNextPage
  });

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  final scrollControler = ScrollController();
  
  @override
  void initState() {
    super.initState();
    scrollControler.addListener(() {
      if(widget.loadNextPage == null) return;

      if((scrollControler.position.pixels + 100) >= scrollControler.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MasonryGridView.count(
        controller: scrollControler,
        itemCount: widget.movieList.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                MoviePosterLink(movie: widget.movieList[index])
              ],
            );
          }
          return MoviePosterLink(movie: widget.movieList[index]);
        },
      ),
    );
  }
}