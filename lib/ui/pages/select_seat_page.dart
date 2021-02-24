part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  final PageEvent pageEvent;

  SelectSeatPage(this.ticket, this.pageEvent);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSchedulePage(
            widget.ticket.movieDetail, widget.pageEvent));

        return;
      },
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  context.bloc<PageBloc>().add(GoToSelectSchedulePage(
                      widget.ticket.movieDetail, widget.pageEvent));
                },
              ),
              toolbarHeight: 100,
              flexibleSpace: SafeArea(
                  child: Container(
                height: 100,
                margin: EdgeInsets.only(right: defaultMargin),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(widget.ticket.movieDetail.title,
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextFont.copyWith(fontSize: 18)),
                    ),
                    SizedBox(width: 16),
                    Container(
                      height: 80,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$imageBaseURL/w154/${widget.ticket.movieDetail.posterPath}"),
                              fit: BoxFit.cover)),
                    )
                  ],
                ),
              ))),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(height: 84, child: Image.asset("assets/screen.png")),
                generateSeats(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    descriptionBox("Available", Colors.white, true),
                    descriptionBox("Booked", Color(0xFFE4E4E4), false),
                    descriptionBox("Selected", accentColor2, false),
                  ],
                ),
                SizedBox(height: 30),
                FloatingActionButton(
                  onPressed: () {
                    if (selectedSeats.length > 0) {
                      context.bloc<PageBloc>().add(GoToCheckoutMoviePage(
                          widget.ticket.copyWith(seats: selectedSeats),
                          widget.pageEvent));
                    }
                  },
                  elevation: 0,
                  backgroundColor: (selectedSeats.length > 0)
                      ? mainColor
                      : Color(0xFFE4E4E4),
                  child: Icon(
                    Icons.arrow_forward,
                    color: (selectedSeats.length > 0)
                        ? Colors.white
                        : Color(0xFFBEBEBE),
                  ),
                ),
                SizedBox(height: 30)
              ],
            ),
          )),
    );
  }

  Row descriptionBox(String desc, Color color, bool hasBorder) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: (hasBorder) ? Color(0xFFE4E4E4) : Colors.transparent),
              color: color),
        ),
        SizedBox(width: 8),
        Text(desc, style: greyTextFont.copyWith(fontSize: 10))
      ],
    );
  }

  Column generateSeats() {
    List<int> rowOfSeat = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < rowOfSeat.length; i++) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(rowOfSeat[i], (index) {
            String seatNumber = "${String.fromCharCode(i + 65)}${index + 1}";
            return Padding(
              padding:
                  EdgeInsets.only(right: index < rowOfSeat[i] - 1 ? 16 : 0),
              child: SelectableBox(
                seatNumber,
                height: 40,
                width: 40,
                isSelected: selectedSeats.contains(seatNumber),
                onTap: () {
                  if (selectedSeats.contains(seatNumber)) {
                    setState(() {
                      selectedSeats.remove(seatNumber);
                    });
                  } else {
                    if ((i != 4 || index != 1) &&
                        (i != 4 || index != 0) &&
                        (i != 1 || index != 3) &&
                        (i != 1 || index != 4)) {
                      setState(() {
                        selectedSeats.add(seatNumber);
                      });
                    }
                  }
                },
                isEnabled: ((i != 4 || index != 1) &&
                    (i != 4 || index != 0) &&
                    (i != 1 || index != 3) &&
                    (i != 1 || index != 4)),
                textStyle: whiteNumberFont.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            );
          }),
        ),
      );

      widgets.add(SizedBox(height: 16));
    }

    return Column(
      children: widgets,
    );
  }
}
