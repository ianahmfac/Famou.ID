part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 136,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/v_logo.png")),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                "New Experience",
                style: blackTextFont.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              "Watch a new movie much\neasier than any before",
              style: greyTextFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 46,
              width: 250,
              margin: EdgeInsets.only(top: 70, bottom: 20),
              child: RaisedButton(
                onPressed: () {
                  context
                      .bloc<PageBloc>()
                      .add(GoToRegistrationPage(RegistrationData()));
                },
                color: mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text("Get Started",
                    style: whiteTextFont.copyWith(fontSize: 16)),
              ),
            ),
            FlatButton(
              onPressed: () {
                context.bloc<PageBloc>().add(GoToLoginPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: greyTextFont.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Sign In",
                    style: purpleTextFont.copyWith(fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
