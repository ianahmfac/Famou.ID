part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);
  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Confirm New Account",
                textAlign: TextAlign.center,
                style: blackTextFont.copyWith(fontWeight: FontWeight.w600)),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToPreferencePage(widget.registrationData));
              },
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                (widget.registrationData.profileImage == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Welcome",
                          style: blackTextFont.copyWith(fontSize: 16)),
                      SizedBox(height: 4),
                      Text(widget.registrationData.name,
                          style: blackTextFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  (isSigningUp)
                      ? SpinKitRing(
                          color: Color(0xFF3E9D9D),
                          size: 45,
                        )
                      : Container(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });
                              var user = widget.registrationData;
                              imageFileToUpload = user.profileImage;
                              var result = await AuthService.signUp(
                                  user.email,
                                  user.password,
                                  user.name,
                                  user.selectedGenres,
                                  user.selectedLanguage);

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                  Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      backgroundColor: Color(0xFFFF5C83),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: result.msg)
                                    ..show(context);
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Color(0xFF3E9D9D),
                            child: Text("Create My Account",
                                style: whiteTextFont.copyWith(fontSize: 16)),
                          ),
                        )
                ],
              ),
            ),
          )),
    );
  }
}
