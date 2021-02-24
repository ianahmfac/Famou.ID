part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;

  MainPage({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          Container(
            color: Color(0xFFF6F7F9),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                bottomNavBarIndex = value;
              });
            },
            children: [
              MoviePage(),
              TicketPage(
                isExpiredTickets: widget.isExpired,
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor2,
        elevation: 8,
        onPressed: () {
          context.bloc<PageBloc>().add(GoToTopUpPage(GoToMainPage()));
        },
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.cartArrowDown,
            color: accentColor1,
            size: 20,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.ticketAlt), label: "My Tickets"),
        ],
        onTap: (value) {
          setState(() {
            bottomNavBarIndex = value;
            pageController.jumpToPage(value);
          });
        },
        currentIndex: bottomNavBarIndex,
        selectedItemColor: mainColor,
      ),
    );
  }
}
