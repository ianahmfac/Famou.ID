part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class OnInitialPage extends PageState {}

class OnLoginPage extends PageState {}

class OnSplashPage extends PageState {}

class OnMainPage extends PageState {
  final int bottomNavBarIndex;
  final bool isExpired;

  OnMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);
}

class OnPreferencePage extends PageState {
  final RegistrationData registrationData;

  OnPreferencePage(this.registrationData);
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);
}

class OnMovieDetailPage extends PageState {
  final Movie movie;
  final bool isNowPlaying;
  final PageEvent pageEvent;
  OnMovieDetailPage(this.movie, this.isNowPlaying, this.pageEvent);

  @override
  List<Object> get props => [movie, isNowPlaying, pageEvent];
}

class OnSelectSchedulePage extends PageState {
  final MovieDetail movieDetail;
  final PageEvent pageEvent;

  OnSelectSchedulePage(this.movieDetail, this.pageEvent);

  @override
  List<Object> get props => [movieDetail, pageEvent];
}

class OnSelectSeatPage extends PageState {
  final Ticket ticket;
  final PageEvent pageEvent;

  OnSelectSeatPage(this.ticket, this.pageEvent);

  @override
  List<Object> get props => [ticket, pageEvent];
}

class OnCheckoutMoviePage extends PageState {
  final Ticket ticket;
  final PageEvent pageEvent;

  OnCheckoutMoviePage(this.ticket, this.pageEvent);

  @override
  List<Object> get props => [ticket, pageEvent];
}

class OnSuccessPage extends PageState {
  final Ticket ticket;
  final AppTransaction transaction;

  OnSuccessPage(this.ticket, this.transaction);

  @override
  List<Object> get props => [ticket, transaction];
}

class OnTicketDetail extends PageState {
  final Ticket ticket;

  OnTicketDetail(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class OnSettingsPage extends PageState {}

class OnTopUpPage extends PageState {
  final PageEvent pageEvent;

  OnTopUpPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class OnWalletPage extends PageState {
  final PageEvent pageEvent;

  OnWalletPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class OnProfilePage extends PageState {
  final User user;

  OnProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

class OnMovieGenrePage extends PageState {
  final String genre, region;

  OnMovieGenrePage(this.genre, this.region);

  @override
  List<Object> get props => [genre, region];
}
