part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final bool isSeleceted;
  final double height;
  final double width;
  final DateTime date;
  final Function onTap;

  DateCard(this.date,
      {this.isSeleceted = false,
      this.height = 90,
      this.width = 70,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSeleceted ? accentColor2 : Colors.transparent,
            border: Border.all(
                color: isSeleceted ? Colors.transparent : Color(0xFFE4E4E4))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.shortDayName,
              style: blackTextFont.copyWith(fontSize: 16),
            ),
            SizedBox(height: 6),
            Text(
              date.day.toString(),
              style:
                  whiteNumberFont.copyWith(color: Colors.black, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
