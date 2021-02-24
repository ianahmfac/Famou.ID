part of 'widgets.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  final List<AppTransaction> transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: transaction.map((index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 70,
                  margin: EdgeInsets.only(right: 16),
                  child: (index.picture != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              "$imageBaseURL/w500/${index.picture}",
                              fit: BoxFit.cover),
                        )
                      : Image.asset("assets/bg_topup.png"),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        NumberFormat.currency(
                                locale: "id_ID", decimalDigits: 0, symbol: "Rp")
                            .format(index.amount)
                            .replaceAll("-", ""),
                        style: whiteNumberFont.copyWith(
                            color: index.amount < 0
                                ? Color(0xFFFF5C83)
                                : Color(0xFF3E9D9D),
                            fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        index.subtitle,
                        style: greyTextFont.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
