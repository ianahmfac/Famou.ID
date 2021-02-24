part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  bool isObscurePassword = true;
  bool isObscureRetypePassword = true;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToLoginPage());
        return;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Create New Account",
                textAlign: TextAlign.center,
                style: blackTextFont.copyWith(fontWeight: FontWeight.w600)),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  context.bloc<PageBloc>().add(GoToLoginPage());
                }),
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    //* For profile pic + button add/remove
                    Container(
                      width: 90,
                      height: 104,
                      margin: EdgeInsetsDirectional.only(top: 20),
                      child: Stack(
                        children: [
                          //* Profile Picture
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (widget
                                              .registrationData.profileImage ==
                                          null)
                                      ? AssetImage("assets/user_pic.png")
                                      : FileImage(
                                          widget.registrationData.profileImage),
                                )),
                          ),
                          //* Button Add/Remove
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (widget.registrationData.profileImage ==
                                    null) {
                                  widget.registrationData.profileImage =
                                      await getImage();
                                } else {
                                  widget.registrationData.profileImage = null;
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage((widget.registrationData
                                                  .profileImage ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                //* Full name
                TextField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Full Name",
                  ),
                ),
                SizedBox(height: 16),
                //* Email Address
                TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Email Address",
                  ),
                ),
                SizedBox(height: 16),
                //* Password
                TextField(
                  controller: passwordController,
                  obscureText: isObscurePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                        icon: Icon(
                            (isObscurePassword)
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 18),
                        onPressed: () {
                          setState(() {
                            isObscurePassword = !isObscurePassword;
                          });
                        }),
                    labelText: "Password",
                  ),
                ),
                SizedBox(height: 16),
                //* Confirm Password
                TextField(
                  controller: retypePasswordController,
                  obscureText: isObscureRetypePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                        icon: Icon(
                            (isObscureRetypePassword)
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 18),
                        onPressed: () {
                          setState(() {
                            isObscureRetypePassword = !isObscureRetypePassword;
                          });
                        }),
                    labelText: "Confirm Password",
                  ),
                ),
                SizedBox(height: 30),
                FloatingActionButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty &&
                        emailController.text.trim().isEmpty &&
                        passwordController.text.trim().isEmpty &&
                        retypePasswordController.text.trim().isEmpty) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Please fill all the fields",
                      )..show(context);
                    } else if (passwordController.text !=
                        retypePasswordController.text) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Mismatch password and confirmed password",
                      )..show(context);
                    } else if (passwordController.text.length < 6) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Password's Length min 6 characters",
                      )..show(context);
                    } else if (!EmailValidator.validate(emailController.text)) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Wrong formatted email address",
                      )..show(context);
                    } else {
                      widget.registrationData.email = emailController.text;
                      widget.registrationData.name = nameController.text;
                      widget.registrationData.password =
                          passwordController.text;

                      context
                          .bloc<PageBloc>()
                          .add(GoToPreferencePage(widget.registrationData));
                    }
                  },
                  backgroundColor: mainColor,
                  elevation: 0,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
