import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'upcomingmovie_event.dart';
part 'upcomingmovie_state.dart';

class UpcomingmovieBloc extends Bloc<UpcomingmovieEvent, UpcomingmovieState> {
  @override
  Stream<UpcomingmovieState> mapEventToState(
    UpcomingmovieEvent event,
  ) async* {
    if (event is FetchUpcomingMovies) {
      List<Movie> movies = await MovieService.getUpcomingMovies(1);
      yield UpcomingMovieLoaded(movies);
    }
  }

  @override
  UpcomingmovieState get initialState => UpcomingmovieInitial();
}
