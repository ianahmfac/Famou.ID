import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage(
          bottomNavBarIndex: event.bottomNavBarIndex,
          isExpired: event.isExpired);
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToMovieDetailPage) {
      yield OnMovieDetailPage(event.movie, event.isNowPlaying, event.pageEvent);
    } else if (event is GoToSelectSchedulePage) {
      yield OnSelectSchedulePage(event.movieDetail, event.pageEvent);
    } else if (event is GoToSelectSeatPage) {
      yield OnSelectSeatPage(event.ticket, event.pageEvent);
    } else if (event is GoToCheckoutMoviePage) {
      yield OnCheckoutMoviePage(event.ticket, event.pageEvent);
    } else if (event is GoToSuccessPage) {
      yield OnSuccessPage(event.ticket, event.transaction);
    } else if (event is GoToTicketDetail) {
      yield OnTicketDetail(event.ticket);
    } else if (event is GoToSettingsPage) {
      yield OnSettingsPage();
    } else if (event is GoToTopUpPage) {
      yield OnTopUpPage(event.pageEvent);
    } else if (event is GoToWalletPage) {
      yield OnWalletPage(event.pageEvent);
    } else if (event is GoToProfilePage) {
      yield OnProfilePage(event.user);
    } else if (event is GoToMovieGenrePage) {
      yield OnMovieGenrePage(event.genre, event.region);
    }
  }
}
