part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final AppTransaction transaction;

  SuccessPage(this.ticket, this.transaction);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
          body: FutureBuilder(
              future: ticket != null
                  ? processingTicketOrder(context)
                  : processingTopUp(context),
              builder: (context, snapshot) => (snapshot.connectionState ==
                      ConnectionState.done)
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            (ticket != null)
                                ? "assets/ticket_done.png"
                                : "assets/top_up_done.png",
                            height: 150,
                            width: 150,
                          ),
                          Column(
                            children: [
                              Text(
                                  (ticket != null)
                                      ? "Happy Watching!"
                                      : "Yay Yummy!",
                                  textAlign: TextAlign.center,
                                  style: blackTextFont.copyWith(fontSize: 20)),
                              SizedBox(height: 16),
                              Text(
                                (ticket != null)
                                    ? "You have successfully\nbought the ticket"
                                    : "You have successfully\ntop up your wallet",
                                textAlign: TextAlign.center,
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 45,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2 * defaultMargin),
                                child: RaisedButton(
                                  onPressed: () {
                                    if (ticket != null) {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToTicketDetail(ticket));
                                    } else {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToWalletPage(GoToMainPage()));
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  color: mainColor,
                                  child: Text(
                                    (ticket != null)
                                        ? "See Ticket"
                                        : "My Wallet",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              FlatButton(
                                onPressed: () {
                                  context.bloc<PageBloc>().add(GoToMainPage());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Discover new movie? ",
                                      style: greyTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Back To Home",
                                      style:
                                          purpleTextFont.copyWith(fontSize: 14),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    ))),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userId));

    await TransactionService.setTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await TransactionService.setTransaction(transaction);
  }
}
