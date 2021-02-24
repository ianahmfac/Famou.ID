part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) => (state is OnSplashPage)
          ? SplashPage()
          : (state is OnLoginPage)
              ? SignInPage()
              : (state is OnRegistrationPage)
                  ? SignUpPage(state.registrationData)
                  : (state is OnPreferencePage)
                      ? PreferencePage(state.registrationData)
                      : (state is OnAccountConfirmationPage)
                          ? AccountConfirmationPage(state.registrationData)
                          : (state is OnMovieDetailPage)
                              ? MovieDetailPage(
                                  state.movie,
                                  state.isNowPlaying,
                                  state.pageEvent,
                                )
                              : (state is OnSelectSchedulePage)
                                  ? SelectSchedulePage(
                                      state.movieDetail, state.pageEvent)
                                  : (state is OnSelectSeatPage)
                                      ? SelectSeatPage(
                                          state.ticket, state.pageEvent)
                                      : (state is OnCheckoutMoviePage)
                                          ? CheckoutMoviePage(
                                              state.ticket, state.pageEvent)
                                          : (state is OnSuccessPage)
                                              ? SuccessPage(state.ticket,
                                                  state.transaction)
                                              : (state is OnTicketDetail)
                                                  ? TicketDetail(state.ticket)
                                                  : (state is OnSettingsPage)
                                                      ? SettingsPage()
                                                      : (state is OnTopUpPage)
                                                          ? TopUpPage(
                                                              state.pageEvent)
                                                          : (state
                                                                  is OnWalletPage)
                                                              ? WalletPage(state
                                                                  .pageEvent)
                                                              : (state
                                                                      is OnProfilePage)
                                                                  ? ProfilePage(
                                                                      state
                                                                          .user)
                                                                  : (state
                                                                          is OnMovieGenrePage)
                                                                      ? MovieGenrePage(
                                                                          state
                                                                              .genre,
                                                                          state
                                                                              .region)
                                                                      : MainPage(
                                                                          bottomNavBarIndex:
                                                                              (state as OnMainPage).bottomNavBarIndex,
                                                                          isExpired:
                                                                              (state as OnMainPage).isExpired,
                                                                        ),
    );
  }
}
