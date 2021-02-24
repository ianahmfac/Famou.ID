part of 'pages.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset("assets/h_logo.png", height: 30),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              context.bloc<PageBloc>().add(GoToMainPage());
            },
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
          if (userState is UserLoaded) {
            var user = userState.user;
            return Container(
              color: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowImage(user.profilePicture),
                            ),
                          );
                        },
                        child: Hero(
                          tag: "image",
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (user.profilePicture != "")
                                    ? NetworkImage(user.profilePicture)
                                    : AssetImage("assets/user_pic.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user.name,
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        user.email,
                        textAlign: TextAlign.center,
                        style: greyTextFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: 30),
                      SettingsMenu(FontAwesomeIcons.edit, "Edit Profile", () {
                        context.bloc<PageBloc>().add(GoToProfilePage(user));
                      }),
                      SizedBox(height: 10),
                      SettingsMenu(FontAwesomeIcons.wallet, "My Wallet", () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToWalletPage(GoToSettingsPage()));
                      }),
                      SizedBox(height: 10),
                      SettingsMenu(
                          FontAwesomeIcons.laptopCode, "About Developer", () {
                        _showDialog(
                          context,
                          title: "About Developer",
                          content: _aboutDevsContent(),
                        );
                      }),
                      SizedBox(height: 10),
                      SettingsMenu(FontAwesomeIcons.infoCircle, "About Apps",
                          () {
                        _showDialog(
                          context,
                          title: "About Famou.ID",
                          content: _aboutAppsContent(),
                        );
                      }),
                      SizedBox(height: 10),
                      SettingsMenu(
                        FontAwesomeIcons.signOutAlt,
                        "Sign Out",
                        () {
                          Alert(
                              context: context,
                              title: "Sign Out?",
                              desc:
                                  "Do you want to sign out from this account?",
                              type: AlertType.error,
                              style: AlertStyle(
                                titleStyle: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold),
                                descStyle: blackTextFont.copyWith(fontSize: 14),
                                animationType: AnimationType.fromBottom,
                              ),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Cancel",
                                    style: blackTextFont.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                  color: Colors.grey[300],
                                ),
                                DialogButton(
                                  child: Text(
                                    "Sign Out",
                                    style: blackTextFont.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context.bloc<UserBloc>().add(SignOut());
                                    AuthService.signOut();
                                  },
                                )
                              ]).show();
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Famou.ID",
                        style: greyTextFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "\u00A9 Ian Ahmad Fachriza, ${DateTime.now().year}",
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: accentColor2,
              size: 50,
            );
          }
        }),
      ),
    );
  }

  void _showDialog(BuildContext context,
      {@required String title, @required Widget content}) {
    Alert(
      context: context,
      title: title,
      content: content,
      type: AlertType.info,
      style: AlertStyle(
        animationType: AnimationType.fromBottom,
        titleStyle: blackTextFont.copyWith(fontWeight: FontWeight.bold),
      ),
    ).show();
  }

  Widget _aboutAppsContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Famou.ID is a cinema ticket booking simulation application, created using the Flutter framework with the Dart programming language. This application consume Movies API from https://themoviedb.org\n\nYou can search for now playing movies, upcoming movies, movies by genre and region that you like and you can simulate ticket bookings.\n",
            textAlign: TextAlign.justify,
            style: blackTextFont.copyWith(fontSize: 12),
          ),
          Text(
            "Special Thanks for the icons. Icons made by:\n\n-> Pixel Perfect www.flaticon.com\n-> Flat Icons www.flaticon.com\n-> Freepik www.flaticon.com",
            style: blackTextFont.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _aboutDevsContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Hello, my name is Ian Ahmad Fachriza (22 years old) from Watampone, South Sulawesi, Indonesia.\n\nI work as a programmer at a private bank in Indonesia. I am experienced in the programming world, especially in mobile application development.\n\nI have experience in the Dart programming language for Flutter, Kotlin and Java. Nice to meet you, I hope you like this application :).\n",
            textAlign: TextAlign.justify,
            style: blackTextFont.copyWith(fontSize: 12),
          ),
          _buildContactRow(
              FontAwesomeIcons.mailBulk, "me.business25@gmail.com"),
          SizedBox(height: 8),
          _buildContactRow(FontAwesomeIcons.linkedin,
              "https://www.linkedin.com/in/ianahmadfachriza/"),
          SizedBox(height: 8),
          _buildContactRow(
              FontAwesomeIcons.github, "https://github.com/ianahmfac"),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        FaIcon(
          icon,
          size: 14,
          color: Colors.blue,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: blackTextFont.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class SettingsMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPress;

  SettingsMenu(this.icon, this.title, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: FlatButton(
        onPressed: onPress,
        height: 34,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                FaIcon(icon, color: mainColor, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: blackTextFont.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Divider(
              thickness: 1,
              color: accentColor3,
            ),
          ],
        ),
      ),
    );
  }
}
