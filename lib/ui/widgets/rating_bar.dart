part of 'widgets.dart';

class RatingStar extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final bool isWhite;
  final bool isCenter;

  RatingStar(
      {this.voteAverage = 0,
      this.starSize = 14,
      this.fontSize = 12,
      this.isWhite = true,
      this.isCenter = false});

  @override
  Widget build(BuildContext context) {
    double n = (voteAverage / 2);
    List<Widget> widgets = List.generate(5, (index) {
      return FaIcon(
        index + 1 <= n
            ? FontAwesomeIcons.solidStar
            : (index + 0.5 <= n)
                ? FontAwesomeIcons.starHalfAlt
                : FontAwesomeIcons.star,
        color: accentColor2,
        size: starSize,
      );
    });

    widgets.add(SizedBox(width: 3));
    widgets.add(Text(
      "$voteAverage/10",
      style: (isWhite ? whiteNumberFont : greyNumberFont)
          .copyWith(fontWeight: FontWeight.w300, fontSize: fontSize),
    ));
    return Row(
      mainAxisAlignment:
          isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: widgets,
    );
  }
}
