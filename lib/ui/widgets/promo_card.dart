part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  PromoCard(this.promo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Alert(
              context: context,
              title: "Information",
              desc:
                  "Thank you for using this application. This feature will coming in future. So, don't missed it!",
              type: AlertType.info,
              style: AlertStyle(
                descStyle: blackTextFont.copyWith(fontSize: 14),
                titleStyle: blackTextFont.copyWith(fontWeight: FontWeight.bold),
                animationType: AnimationType.fromBottom,
              ),
            ).show();
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: mainColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        promo.title,
                        style: whiteTextFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        promo.subtitle,
                        style: greyTextFont.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "OFF ",
                      style: yellowNumberFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "${promo.discount}%",
                      style: yellowNumberFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        //* Reflection on left
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
                    colors: [Colors.black.withOpacity(0.1), Colors.transparent],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft)
                .createShader(Rect.fromLTRB(0, 0, 96.875, 100));
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
              height: 100,
              width: 96.875,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.asset("assets/reflection2.png"),
              )),
        ),
        //* Reflection big on Top Right
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent
              ], end: Alignment.centerRight, begin: Alignment.centerLeft)
                  .createShader(Rect.fromLTRB(0, 0, 117.333, 55));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
                height: 55,
                width: 117.333,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
                  child: Image.asset("assets/reflection1.png"),
                )),
          ),
        ),
        //* Reflection small on Top Right
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent
              ], end: Alignment.centerRight, begin: Alignment.centerLeft)
                  .createShader(Rect.fromLTRB(0, 0, 100, 35));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
                height: 35,
                width: 117.333,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
                  child: Image.asset("assets/reflection3.png"),
                )),
          ),
        )
      ],
    );
  }
}
