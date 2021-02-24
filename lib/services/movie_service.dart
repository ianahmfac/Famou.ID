part of 'services.dart';

class MovieService {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "$baseURL/movie/now_playing?api_key=$apiKey&language=en-US&page=$page";

    client ??= http.Client();

    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<List<Movie>> getUpcomingMovies(int page,
      {http.Client client}) async {
    String url =
        "$baseURL/movie/upcoming?api_key=$apiKey&language=en-US&page=$page";

    client ??= http.Client();

    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<List<Movie>> getMovieByGenre(int genreId, String region, {http.Client client}) async{
    String url = "$baseURL/discover/movie?api_key=$apiKey&language=en-US&region=$region&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId";
    client ??= http.Client();

    var response = await client.get(url);
    if(response.statusCode != 200) return [];

    var data =json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetailMovie(Movie movie,
      {int movieId, http.Client client}) async {
    String url =
        "$baseURL/movie/${movieId ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;
    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'en':
        language = "English";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
    }

    return movieId != null
        ? MovieDetail(Movie.fromJson(data),
        language: language,
        genres: genres
            .map((e) => (e as Map<String, dynamic>)["name"].toString())
            .toList())
        : MovieDetail(movie,
        language: language,
        genres: genres
            .map((e) => (e as Map<String, dynamic>)["name"].toString())
            .toList());
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url = "$baseURL/movie/$movieId/credits?api_key=$apiKey";

    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) =>
        Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path'],
            character: (e as Map<String, dynamic>)['character']))
        .toList();
  }
}
