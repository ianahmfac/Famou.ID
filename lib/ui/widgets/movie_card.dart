part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  final bool isNowPlaying;

  MovieCard(this.movie, {this.onTap, this.isNowPlaying = true});
  @override
  Widget build(BuildContext context) {
    return (isNowPlaying)
        ?
        //* Now Playing Movie
        GestureDetector(
            onTap: onTap,
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: NetworkImage(
                          "$imageBaseURL/w780/${movie.backdropPath}"),
                      fit: BoxFit.cover)),
              //* Image Bottom Black Gradation
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.black.withOpacity(0),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: whiteTextFont.copyWith(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    RatingStar(voteAverage: movie.voteAverage),
                  ],
                ),
              ),
            ),
          )
        :
        //* Upcoming Movie
        GestureDetector(
            onTap: onTap,
            child: Container(
              height: 170,
              width: 120,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          "$imageBaseURL/w500/${movie.posterPath}"),
                      fit: BoxFit.cover)),
            ),
          );
  }
}
