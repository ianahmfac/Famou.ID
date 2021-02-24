part of 'widgets.dart';

class ShowImage extends StatelessWidget {
  final String url;

  ShowImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: "image",
              child: Container(
                child: (url != "")
                    ? Image.network(
                        url,
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/user_pic.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
