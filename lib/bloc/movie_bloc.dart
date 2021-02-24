import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovies) {
      List<Movie> movies = await MovieService.getMovies(1);
      yield MovieLoaded(movies);
    }
  }

  @override
  MovieState get initialState => MovieInitial();
}
