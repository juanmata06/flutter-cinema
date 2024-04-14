import "package:animate_do/animate_do.dart";
import "package:flutter_cinema/domain/entities/movie.dart";
import "package:card_swiper/card_swiper.dart";
import "package:flutter/material.dart";

class MoviesSlideShow extends StatelessWidget { // Clase para mostrar un carousel de peliculas
  final List<Movie> movies;

  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Widget del carousel con sus atributos
      height: 210,
      width: double.infinity,
      child: Swiper( //
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          itemCount: movies.length,
          // Cadapos del slide mostrara otra clase privada que crearemos llamada _Slide:
          itemBuilder: (context, index) => _Slide(movie: movies[index])),
    );
  }
}

class _Slide extends StatelessWidget { // Clase que muestra una card
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect( // Con ClipRRect creamos un widget que asemeja una card con sus atributos
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) { // loadingBuilder nos permite añadir acciones al momento de cargar, en este caso de la imagen (en lo que se renderiza)
                  if (loadingProgress != null) {
                    return const DecoratedBox( // Mostramos una caja gris mientras que se carga
                        decoration: BoxDecoration(color: Colors.black12));
                  }
                  return FadeIn(child: child); // Al momento de cargar y mostrar la imagen de la pelicula lo hacemos un  con una animación
                },
              ))),
    );
  }
}
