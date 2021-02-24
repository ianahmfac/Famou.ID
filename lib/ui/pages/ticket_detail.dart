part of 'pages.dart';

class TicketDetail extends StatelessWidget {
  final Ticket ticket;

  TicketDetail(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(
            bottomNavBarIndex: 1,
            isExpired: ticket.time.isBefore(DateTime.now())));
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ticket Detail", style: whiteTextFont),
          centerTitle: true,
          backgroundColor: accentColor1,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              context.bloc<PageBloc>().add(GoToMainPage(
                  bottomNavBarIndex: 1,
                  isExpired: ticket.time.isBefore(DateTime.now())));
            },
          ),
        ),
        body: Container(
            color: accentColor1,
            padding: EdgeInsets.all(defaultMargin),
            child: FlutterTicketWidget(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              isCornerRounded: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Image.network(
                        "$imageBaseURL/w500/${ticket.movieDetail.backdropPath}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                ticket.movieDetail.title,
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: 16),
                            DetailTransaction("Cinema", ticket.cinema.name),
                            SizedBox(height: 2),
                            DetailTransaction(
                                "Date & Time", ticket.time.dateAndTime),
                            SizedBox(height: 2),
                            DetailTransaction(
                                "Seat Number", ticket.seatsInString),
                            SizedBox(height: 2),
                            DetailTransaction("Name", ticket.name),
                            SizedBox(height: 8),
                            Text(
                              "Note :",
                              style: greyTextFont.copyWith(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "*Please coming early and scan QR Code below on the ticket machine at ${ticket.cinema.name}",
                              style: greyTextFont.copyWith(fontSize: 10),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "*Tap QR Code below for fullscreen QR Code",
                              style: greyTextFont.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Divider(
                            color: accentColor1,
                            thickness: 2,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreenQR(
                                              ticket.bookingCode)));
                                },
                                child: Hero(
                                  tag: "qr",
                                  child: QrImage(
                                      data: ticket.bookingCode,
                                      version: 2,
                                      size: 80,
                                      foregroundColor: accentColor1,
                                      errorCorrectionLevel:
                                          QrErrorCorrectLevel.M),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ticket.bookingCode,
                                    textAlign: TextAlign.center,
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    NumberFormat.currency(
                                      locale: "id_ID",
                                      symbol: "Rp",
                                    ).format(ticket.totalPrice),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class DetailTransaction extends StatelessWidget {
  final String title;
  final String value;

  DetailTransaction(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: greyTextFont.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w400)),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: whiteNumberFont.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenQR extends StatelessWidget {
  final String qrData;

  FullScreenQR(this.qrData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: accentColor1,
          elevation: 0,
          title: Text(qrData, style: whiteTextFont),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Container(
        color: accentColor1,
        padding: EdgeInsets.all(defaultMargin),
        child: Center(
          child: Hero(
            tag: "qr",
            child: QrImage(
                backgroundColor: Colors.white,
                data: qrData,
                size: 250,
                version: 2,
                foregroundColor: accentColor1,
                errorCorrectionLevel: QrErrorCorrectLevel.M),
          ),
        ),
      ),
    );
  }
}
