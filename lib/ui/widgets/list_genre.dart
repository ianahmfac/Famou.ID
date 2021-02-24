part of 'widgets.dart';

class ListGenre extends StatelessWidget {
  final Movie movie;
  final Function onPressedGenre;

  ListGenre(this.movie, this.onPressedGenre);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onPressedGenre,
        child: Card(
            elevation: 5,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                  child: Image.network(
                    "$imageBaseURL/w500/${movie.posterPath}",
                    fit: BoxFit.cover,
                    height: 150,
                    width: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: greyTextFont.copyWith(fontSize: 10),
                        ),
                        SizedBox(height: 8),
                        RatingStar(
                          voteAverage: movie.voteAverage,
                          isWhite: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
