part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final isExpiredTickets;

  TicketPage({this.isExpiredTickets = false});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets;

  @override
  void initState() {
    isExpiredTickets = widget.isExpiredTickets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<TicketBloc, TicketState>(
            builder: (context, ticketState) => Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(
                isExpiredTickets
                    ? ticketState.tickets
                        .where(
                            (element) => element.time.isBefore(DateTime.now()))
                        .toList()
                    : ticketState.tickets
                        .where(
                            (element) => !element.time.isBefore(DateTime.now()))
                        .toList(),
              ),
            ),
          ),
          headerTickets(context),
        ],
      ),
    );
  }

  Widget headerTickets(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Container(
        height: 150,
        color: accentColor1,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 24, bottom: 32),
                child: Text(
                  "My Tickets",
                  style: whiteTextFont.copyWith(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpiredTickets = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Active Ticket",
                          style: whiteTextFont.copyWith(
                              fontSize: 16,
                              color: !isExpiredTickets
                                  ? Colors.white
                                  : Color(0xFF6F678E)),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 4,
                          width: MediaQuery.of(context).size.width / 2,
                          color: !isExpiredTickets
                              ? accentColor2
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpiredTickets = true;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Ticket History",
                          style: whiteTextFont.copyWith(
                              fontSize: 16,
                              color: isExpiredTickets
                                  ? Colors.white
                                  : Color(0xFF6F678E)),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 4,
                          width: MediaQuery.of(context).size.width / 2,
                          color: isExpiredTickets
                              ? accentColor2
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    var sortedTicket = tickets;
    print("Data: ${sortedTicket.length}");
    sortedTicket
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));
    return (sortedTicket.length == 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/empty_data.png",
                  height: 100,
                ),
                SizedBox(height: 30),
                Text(
                  "Oops! Empty Data Here",
                  textAlign: TextAlign.center,
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                    "Purchase your movie watchlist \nto adding it into Active Ticket",
                    textAlign: TextAlign.center,
                    style: greyTextFont),
              ],
            ),
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: sortedTicket.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    top: (index == 0) ? 134 : 10,
                    bottom: (index == sortedTicket.length - 1) ? 30 : 0),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToTicketDetail(sortedTicket[index]));
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          child: Image.network(
                              "$imageBaseURL/w500/${sortedTicket[index].movieDetail.posterPath}",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 90),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sortedTicket[index].movieDetail.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: blackTextFont.copyWith(fontSize: 16),
                              ),
                              SizedBox(height: 6),
                              Text(sortedTicket[index].time.fullDateAndTime,
                                  style: greyNumberFont.copyWith(fontSize: 12)),
                              SizedBox(height: 6),
                              Text("${sortedTicket[index].time.hour}:00",
                                  style: greyNumberFont.copyWith(fontSize: 12)),
                              SizedBox(height: 6),
                              Text(sortedTicket[index].cinema.name,
                                  style: greyTextFont.copyWith(fontSize: 12))
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
