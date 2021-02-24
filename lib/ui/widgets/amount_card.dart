part of 'widgets.dart';

class AmountCard extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final Function onTap;
  final double width;

  AmountCard(
      {this.amount = 0, this.isSelected = false, this.onTap, this.width = 90});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Colors.transparent : Color(0xFFE4E4E4),
          ),
          color: isSelected ? accentColor2 : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rp",
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "")
                  .format(amount),
              style: whiteNumberFont.copyWith(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
