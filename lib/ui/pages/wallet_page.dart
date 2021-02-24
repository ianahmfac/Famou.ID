part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 46,
          width: 46,
          child: FloatingActionButton(
            onPressed: () {
              context
                  .bloc<PageBloc>()
                  .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
            },
            backgroundColor: accentColor2,
            child: FaIcon(FontAwesomeIcons.cartArrowDown,
                size: 16, color: accentColor1),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "My Wallet",
            style: blackTextFont.copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              context.bloc<PageBloc>().add(pageEvent);
            },
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          var user = (state as UserLoaded).user;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserCard(user),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 12),
                      child: Text(
                        'History Transaction',
                        style: blackTextFont,
                      ),
                    ),
                    FutureBuilder(
                      future: TransactionService.getTransaction(user.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<AppTransaction> transaction = snapshot.data;
                          transaction
                              .sort((tr1, tr2) => tr2.time.compareTo(tr1.time));
                          transaction.take(30);
                          return HistoryList(transaction: transaction);
                        } else {
                          return SpinKitDualRing(
                            color: mainColor,
                          );
                        }
                      },
                    ),
                  ],
                )),
          );
        }),
      ),
    );
  }

  Container _buildUserCard(User user) {
    return Container(
      height: 185,
      margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [mainColor, mainColor.withOpacity(0.7)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 5)),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 18,
                  width: 18,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor2,
                  ),
                ),
              ],
            ),
            Text(
              NumberFormat.currency(
                      locale: "id_ID", decimalDigits: 2, symbol: "Rp")
                  .format(user.balance),
              style: whiteNumberFont.copyWith(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                buildCardInfo(
                    (user.name.length > 20)
                        ? user.name.substring(0, 20)
                        : user.name,
                    title: "Account Holder",
                    icon: FontAwesomeIcons.userCheck),
                SizedBox(width: 20),
                buildCardInfo(user.id.substring(0, 10),
                    title: "Card ID", icon: FontAwesomeIcons.certificate)
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildCardInfo(String user, {String title, IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: whiteTextFont.copyWith(
                fontWeight: FontWeight.w200, fontSize: 10)),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              user,
              style: whiteTextFont.copyWith(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            FaIcon(icon, color: accentColor2, size: 12),
          ],
        ),
      ],
    );
  }
}
