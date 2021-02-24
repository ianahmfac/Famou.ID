part of 'upcomingmovie_bloc.dart';

abstract class UpcomingmovieState extends Equatable {
  const UpcomingmovieState();

  @override
  List<Object> get props => [];
}

class UpcomingmovieInitial extends UpcomingmovieState {}

class UpcomingMovieLoaded extends UpcomingmovieState {
  final List<Movie> movies;
  UpcomingMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
