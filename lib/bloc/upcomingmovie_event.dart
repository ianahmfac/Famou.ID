part of 'upcomingmovie_bloc.dart';

abstract class UpcomingmovieEvent extends Equatable {
  const UpcomingmovieEvent();

  @override
  List<Object> get props => [];
}

class FetchUpcomingMovies extends UpcomingmovieEvent {}
