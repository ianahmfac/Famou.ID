part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  final Function onTap;

  BrowseButton(this.genre, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(2, 2), // changes position of shadow
                ),
              ],
              color: Color(0xFFEBEFF6),
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage("assets/ic_${genre.toLowerCase()}.png"),
              ),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 70,
            child: Text(
              genre,
              textAlign: TextAlign.center,
              style: blackTextFont.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
