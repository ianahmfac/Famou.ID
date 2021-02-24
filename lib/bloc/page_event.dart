part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {}

class GoToLoginPage extends PageEvent {}

class GoToMainPage extends PageEvent {
  final int bottomNavBarIndex;
  final bool isExpired;

  GoToMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToRegistrationPage(this.registrationData);
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  GoToPreferencePage(this.registrationData);
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmationPage(this.registrationData);
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;
  final bool isNowPlaying;
  final PageEvent pageEvent;

  GoToMovieDetailPage(this.movie, this.isNowPlaying, this.pageEvent);
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;
  final PageEvent pageEvent;

  GoToSelectSchedulePage(this.movieDetail, this.pageEvent);
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;
  final PageEvent pageEvent;

  GoToSelectSeatPage(this.ticket, this.pageEvent);
}

class GoToCheckoutMoviePage extends PageEvent {
  final Ticket ticket;
  final PageEvent pageEvent;

  GoToCheckoutMoviePage(this.ticket, this.pageEvent);
}

class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final AppTransaction transaction;

  GoToSuccessPage(this.ticket, this.transaction);
}

class GoToTicketDetail extends PageEvent {
  final Ticket ticket;

  GoToTicketDetail(this.ticket);
}

class GoToSettingsPage extends PageEvent {}

class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;

  GoToTopUpPage(this.pageEvent);
}

class GoToWalletPage extends PageEvent {
  final PageEvent pageEvent;

  GoToWalletPage(this.pageEvent);
}

class GoToProfilePage extends PageEvent {
  final User user;

  GoToProfilePage(this.user);
}

class GoToMovieGenrePage extends PageEvent {
  final String genre, region;

  GoToMovieGenrePage(this.genre, this.region);
}
