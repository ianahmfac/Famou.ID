part of 'pages.dart';

class CheckoutMoviePage extends StatefulWidget {
  final Ticket ticket;
  final PageEvent pageEvent;

  CheckoutMoviePage(this.ticket, this.pageEvent);

  @override
  _CheckoutMoviePageState createState() => _CheckoutMoviePageState();
}

class _CheckoutMoviePageState extends State<CheckoutMoviePage> {
  @override
  Widget build(BuildContext context) {
    int total = (widget.ticket.priceInDay + 3000) * widget.ticket.seats.length;
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSeatPage(widget.ticket, widget.pageEvent));
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Checkout Movie",
            style: blackTextFont.copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              context
                  .bloc<PageBloc>()
                  .add(GoToSelectSeatPage(widget.ticket, widget.pageEvent));
            },
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            var user = (userState as UserLoaded).user;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      movieDetail(),
                      Divider(
                        color: Color(0xFFE4E4E4),
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      buildRowTransaction(
                          context, "ID Order", widget.ticket.bookingCode),
                      buildRowTransaction(
                          context, "Cinema", widget.ticket.cinema.name),
                      buildRowTransaction(context, "Date & Time",
                          widget.ticket.time.dateAndTime),
                      buildRowTransaction(
                          context, "Seat Number", widget.ticket.seatsInString),
                      buildRowTransaction(
                          context,
                          "Price",
                          NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "Rp")
                                  .format(widget.ticket.priceInDay) +
                              " x ${widget.ticket.seats.length}"),
                      buildRowTransaction(context, "Fee",
                          "Rp3.000 x ${widget.ticket.seats.length}"),
                      buildRowTransaction(
                          context,
                          "Total",
                          NumberFormat.currency(
                                  locale: "id_ID",
                                  decimalDigits: 2,
                                  symbol: "Rp")
                              .format(total),
                          isTotal: true),
                      SizedBox(height: 20),
                      Divider(
                        color: Color(0xFFE4E4E4),
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Your Wallet",
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25),
                          Expanded(
                            child: Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 2,
                                      symbol: "Rp")
                                  .format(user.balance),
                              textAlign: TextAlign.right,
                              style: whiteNumberFont.copyWith(
                                  color: (user.balance >= total)
                                      ? Color(0xFF3E9D9D)
                                      : Color(0xFFFF5C83),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 36),
                      Container(
                        height: 45,
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: defaultMargin * 2),
                        child: RaisedButton(
                          onPressed: () {
                            if (user.balance >= total) {
                              var transaction = AppTransaction(
                                userId: user.id,
                                title: widget.ticket.movieDetail.title,
                                subtitle: widget.ticket.cinema.name,
                                time: DateTime.now(),
                                amount: -total,
                                picture: widget.ticket.movieDetail.posterPath,
                              );
                              context.bloc<PageBloc>().add(GoToSuccessPage(
                                  widget.ticket.copyWith(totalPrice: total),
                                  transaction));
                            } else {
                              context.bloc<PageBloc>().add(GoToTopUpPage(
                                  GoToCheckoutMoviePage(
                                      widget.ticket, widget.pageEvent)));
                            }
                          },
                          color: (user.balance >= total)
                              ? Color(0xFF3E9D9D)
                              : Color(0xFFFF5C83),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            (user.balance >= total)
                                ? "Checkout Now"
                                : "Top Up My Wallet",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container buildRowTransaction(
      BuildContext context, String title, String value,
      {bool isTotal = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400)),
          SizedBox(width: MediaQuery.of(context).size.width * 0.25),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: whiteNumberFont.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: (isTotal) ? FontWeight.w600 : FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Container movieDetail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "$imageBaseURL/w342/${widget.ticket.movieDetail.posterPath}"))),
          ),
          SizedBox(width: 20),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.ticket.movieDetail.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: blackTextFont.copyWith(fontSize: 18),
              ),
              SizedBox(height: 6),
              Text(widget.ticket.movieDetail.genreAndLanguage,
                  style: greyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400)),
              SizedBox(height: 6),
              RatingStar(
                voteAverage: widget.ticket.movieDetail.voteAverage,
                isWhite: false,
                fontSize: 12,
                starSize: 20,
              )
            ],
          ))
        ],
      ),
    );
  }
}
