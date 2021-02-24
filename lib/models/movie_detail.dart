part of 'models.dart';

class MovieDetail extends Movie {
  final List<String> genres;
  final String language;

  MovieDetail(Movie movie, {this.genres, this.language})
      : super(
          id: movie.id,
          title: movie.title,
          backdropPath: movie.backdropPath,
          overview: movie.overview,
          posterPath: movie.posterPath,
          voteAverage: movie.voteAverage,
          releaseDate: movie.releaseDate,
        );

  String get genreAndLanguage {
    String genreString = "";
    for (var genre in genres) {
      genreString += genre + (genre != genres.last ? ', ' : '');
    }
    return "$genreString - $language";
  }

  @override
  List<Object> get props => super.props + [genres, language];
}
