part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  final PageEvent pageEvent;

  SelectSchedulePage(this.movieDetail, this.pageEvent);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Cinema selectedCinema;
  bool isValid = false;
  int price;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(
            GoToMovieDetailPage(widget.movieDetail, true, widget.pageEvent));
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              context.bloc<PageBloc>().add(GoToMovieDetailPage(
                  widget.movieDetail, true, widget.pageEvent));
            },
          ),
          actions: [
            (isValid)
                ? BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) => FlatButton(
                      child: Text(
                        "Select Seat",
                        style: purpleTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.bloc<PageBloc>().add(
                              GoToSelectSeatPage(
                                  Ticket(
                                      widget.movieDetail,
                                      selectedCinema,
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime),
                                      randomAlphaNumeric(12).toUpperCase(),
                                      null,
                                      (userState as UserLoaded).user.name,
                                      null,
                                      price),
                                  widget.pageEvent),
                            );
                      },
                    ),
                  )
                : SizedBox()
          ],
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  chooseDate(),
                  SizedBox(height: 24),
                  generateTimeTable(),
                  SizedBox(height: 30)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var cinema in dummyCinema) {
      widgets.add(titleText(cinema.name, FontAwesomeIcons.couch));

      widgets.add(Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Text(
          (selectedDate.weekday == 6 || selectedDate.weekday == 7)
              ? "Rp45.000,00"
              : (selectedDate.weekday == 5)
                  ? "Rp35.000,00"
                  : "Rp25.000,00",
          style: yellowNumberFont,
        ),
      ));

      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: schedule.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? defaultMargin : 0,
                      right: index == schedule.length - 1 ? defaultMargin : 16),
                  child: SelectableBox("${schedule[index]}:00",
                      height: 50,
                      isSelected: selectedCinema == cinema &&
                          selectedTime == schedule[index],
                      isEnabled: schedule[index] > DateTime.now().hour ||
                          selectedDate.day != DateTime.now().day, onTap: () {
                    setState(() {
                      if (schedule[index] > DateTime.now().hour ||
                          selectedDate.day != DateTime.now().day) {
                        selectedCinema = cinema;
                        selectedTime = schedule[index];
                        isValid = true;
                        if (selectedDate.weekday == 6 ||
                            selectedDate.weekday == 7) {
                          price = 45000;
                        } else if (selectedDate.weekday == 5) {
                          price = 35000;
                        } else {
                          price = 25000;
                        }
                      }
                    });
                  }),
                )),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Column chooseDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: titleText("Choose Date", FontAwesomeIcons.calendarDay),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: dates.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.fromLTRB((index == 0) ? defaultMargin : 0, 0,
                  (index == dates.length - 1) ? defaultMargin : 16, 0),
              child: DateCard(
                dates[index],
                isSeleceted: dates[index] == selectedDate,
                onTap: () {
                  setState(() {
                    selectedDate = dates[index];
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container titleText(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 8),
      child: Row(
        children: [
          FaIcon(icon, size: 16, color: accentColor1),
          SizedBox(
            width: 8,
          ),
          Text(title,
              style: blackTextFont.copyWith(
                  color: accentColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
