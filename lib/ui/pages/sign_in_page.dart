part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;

  bool isSigningIn = false;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue[100], Colors.white],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter)),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    child: Image.asset("assets/h_logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text("Welcome Back,\nWatchers!",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20)),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(value);
                        });
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: mainColor,
                      textInputAction: TextInputAction.next,
                      style: purpleTextFont.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Email Address"),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          isPasswordValid = value.length >= 6;
                        });
                      },
                      cursorColor: mainColor,
                      controller: passwordController,
                      textInputAction: TextInputAction.go,
                      obscureText: isObscure,
                      style: purpleTextFont.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: (isObscure)
                                ? Icon(Icons.visibility_off, size: 18)
                                : Icon(Icons.visibility, size: 18),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            }),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Password",
                      ),
                      onSubmitted: (isEmailValid && isPasswordValid)
                          ? (value) async {
                              setState(() {
                                isSigningIn = true;
                              });

                              var result = await AuthService.signIn(
                                  emailController.text,
                                  passwordController.text);

                              if (result.user == null) {
                                setState(() {
                                  isSigningIn = false;
                                });
                                print(result.msg);
                                Flushbar(
                                  duration: Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: result.msg,
                                )..show(context);
                              }
                            }
                          : null,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Alert(
                        context: context,
                        title: "Forgot Password?",
                        type: AlertType.warning,
                        content: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: forgotPasswordController,
                            style: blackTextFont.copyWith(fontSize: 14),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Input Your Email",
                              labelStyle: blackTextFont.copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                        buttons: [
                          DialogButton(
                            color: Colors.grey[300],
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel",
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold)),
                          ),
                          DialogButton(
                            color: Color(0xFFFF5C83),
                            onPressed: () async {
                              await AuthService.resetPassword(
                                  forgotPasswordController.text.trim());
                              Navigator.of(context).pop();
                              Flushbar(
                                  backgroundColor: Color(0xFF3E9D9D),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message:
                                      "Your Reset Password's Link was Sent to Your Email",
                                  duration: Duration(milliseconds: 4000))
                                ..show(context);
                            },
                            child: Text("Reset",
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                        style: AlertStyle(
                          titleStyle: blackTextFont.copyWith(
                              fontWeight: FontWeight.bold),
                          descStyle: blackTextFont.copyWith(fontSize: 14),
                          animationType: AnimationType.fromBottom,
                        ),
                      ).show();
                      // showDialog(
                      //   context: context,
                      //   builder: (context) =>
                      //       AlertDialog(
                      //           title: Text("Forgot Password",
                      //               style: blackTextFont.copyWith(
                      //                   fontSize: 16,
                      //                   color: accentColor1,
                      //                   fontWeight: FontWeight.bold)),
                      //           content: TextField(
                      //             controller: forgotPasswordController,
                      //             keyboardType: TextInputType.emailAddress,
                      //             decoration: InputDecoration(
                      //                 labelText: "Input Your Email"
                      //             ),
                      //           ),
                      //           actions: [
                      //             FlatButton(child: Text("Cancel",
                      //                 style: blackTextFont.copyWith(
                      //                     color: mainColor,
                      //                     fontWeight: FontWeight.w300)),
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                 }),
                      //             FlatButton(child: Text("Reset Password",
                      //                 style: blackTextFont.copyWith(
                      //                     color: mainColor,
                      //                     fontWeight: FontWeight.bold)),
                      //                 onPressed: () async {
                      //                   await AuthService.resetPassword(
                      //                       forgotPasswordController.text.trim());
                      //                   Navigator.pop(context);
                      //                   Flushbar(
                      //                     backgroundColor: Color(0xFF3E9D9D),
                      //                     flushbarPosition: FlushbarPosition
                      //                         .TOP,
                      //                     message: "Your Reset Password's Link was Sent to Your Email",
                      //                     duration: Duration(
                      //                         milliseconds: 4000),
                      //                   )
                      //                     ..show(context);
                      //                 }),
                      //           ]
                      //       ),
                      // );
                    },
                    child: Row(
                      children: [
                        Text("Forgot Password? ",
                            style: greyTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Text("Get Now",
                            style: purpleTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: (isSigningIn)
                          ? SpinKitRing(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              onPressed: (isEmailValid && isPasswordValid)
                                  ? () async {
                                      setState(() {
                                        isSigningIn = true;
                                      });

                                      var result = await AuthService.signIn(
                                          emailController.text,
                                          passwordController.text);

                                      if (result.user == null) {
                                        setState(() {
                                          isSigningIn = false;
                                        });
                                        print(result.msg);
                                        Flushbar(
                                          duration: Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: Color(0xFFFF5C83),
                                          message: result.msg,
                                        )..show(context);
                                      }
                                    }
                                  : null,
                              backgroundColor: (isEmailValid && isPasswordValid)
                                  ? mainColor
                                  : Color(0xFFE4E4E4),
                              child: Icon(
                                Icons.arrow_forward,
                                color: (isEmailValid && isPasswordValid)
                                    ? Colors.white
                                    : Color(0xFFBEBEBE),
                              ),
                            ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToRegistrationPage(RegistrationData()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Start Fresh Now? ",
                            style: greyTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Text("Sign Up",
                            style: purpleTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
