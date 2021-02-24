part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name;
  String profilePath = "";
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    name = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSettingsPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: blackTextFont.copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              context.bloc<PageBloc>().add(GoToSettingsPage());
            },
          ),
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Center(child: _buildUserPhoto()),
                  SizedBox(height: 8),
                  Center(child: Text(widget.user.email, style: blackTextFont)),
                  SizedBox(height: 24),
                  Text("Change Your Name", style: greyTextFont),
                  SizedBox(height: 8),
                  TextField(
                    controller: name,
                    onChanged: (value) {
                      setState(() {
                        isDataEdited = (value.trim() != widget.user.name ||
                                profilePath != widget.user.name)
                            ? true
                            : false;
                      });
                    },
                    textInputAction: TextInputAction.done,
                    style: blackTextFont,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: RaisedButton(
                            color: Color(0xFFFF5C83),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: (isUpdating)
                                ? null
                                : () {
                                    Alert(
                                      context: context,
                                      title: "Reset Password?",
                                      type: AlertType.warning,
                                      desc:
                                          "You will receive an email with password reset's LINK!",
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
                                                widget.user.email);
                                            Navigator.of(context).pop();
                                            Flushbar(
                                                backgroundColor:
                                                    Color(0xFF3E9D9D),
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                message:
                                                    "Your Reset Password's Link was Sent to Your Email",
                                                duration: Duration(
                                                    milliseconds: 4000))
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
                                        descStyle: blackTextFont.copyWith(
                                            fontSize: 14),
                                        animationType: AnimationType.fromBottom,
                                      ),
                                    ).show();
                                  },
                            child: Text("Reset Password", style: whiteTextFont),
                          ),
                        ),
                      ),
                      (isUpdating)
                          ? SpinKitRing(
                              color: mainColor,
                            )
                          : Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: RaisedButton(
                                  color: Color(0xFF3E9D9D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  onPressed: isDataEdited
                                      ? () async {
                                          setState(() {
                                            isUpdating = true;
                                          });
                                          if (profileImageFile != null) {
                                            profilePath = await uploadImage(
                                                profileImageFile);
                                          }
                                          context.bloc<UserBloc>().add(
                                              UpdateUserData(
                                                  name: name.text,
                                                  profileImage: profilePath));
                                          context
                                              .bloc<PageBloc>()
                                              .add(GoToSettingsPage());
                                        }
                                      : null,
                                  child: Text("Update Profile",
                                      style: whiteTextFont),
                                ),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Container _buildUserPhoto() {
    return Container(
      margin: EdgeInsets.only(top: 75),
      height: 120,
      width: 100,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (profileImageFile != null)
                    ? FileImage(profileImageFile)
                    : (profilePath != "")
                        ? NetworkImage(profilePath)
                        : AssetImage("assets/user_pic.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                if (profilePath == "") {
                  profileImageFile = await getImage();

                  if (profileImageFile != null) {
                    profilePath = basename(profileImageFile.path);
                  }
                } else {
                  profileImageFile = null;
                  profilePath = "";
                }

                setState(() {
                  isDataEdited = (name.text.trim() != widget.user.name ||
                          profilePath != widget.user.profilePicture)
                      ? true
                      : false;
                });
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage((profilePath != "")
                        ? "assets/btn_del_photo.png"
                        : "assets/btn_add_photo.png"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
