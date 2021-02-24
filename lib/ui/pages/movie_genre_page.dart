part of 'pages.dart';

class MovieGenrePage extends StatelessWidget {
  final String genre;
  final String region;

  MovieGenrePage(this.genre, this.region);

  int _getGenreId(String genre) {
    switch (genre) {
      case 'Action':
        return 28;
      case 'Adventure':
        return 12;
      case 'Animation':
        return 16;
      case 'Comedy':
        return 35;
      case 'Crime':
        return 80;
      case 'Documentary':
        return 99;
      case 'Drama':
        return 18;
      case 'Family':
        return 10751;
      case 'Fantasy':
        return 14;
      case 'History':
        return 36;
      case 'Horror':
        return 27;
      case 'Music':
        return 10402;
      case 'Mystery':
        return 9648;
      case 'Romance':
        return 10749;
      case 'Science Fiction':
        return 878;
      case 'TV Movie':
        return 10770;
      case 'Thriller':
        return 53;
      case 'War':
        return 10752;
    }
    return 0;
  }

  String _getRegionCode(String region) {
    switch (region) {
      case 'English':
        return "us";
      case 'Indonesian':
        return "id";
      case 'Korean':
        return "kr";
      case 'Japanese':
        return "jp";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> movies;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              genre,
              style: blackTextFont,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                context.bloc<PageBloc>().add(GoToMainPage());
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              padding:
                  EdgeInsets.fromLTRB(defaultMargin, 10, defaultMargin, 20),
              child: FutureBuilder(
                future: MovieService.getMovieByGenre(
                    _getGenreId(genre), _getRegionCode(region)),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Movie>> snapshot) {
                  if (snapshot.hasData) {
                    movies = snapshot.data;
                    return Column(
                        children: movies
                            .map((e) => ListGenre(e, () {
                                  context.bloc<PageBloc>().add(
                                      GoToMovieDetailPage(e, true,
                                          GoToMovieGenrePage(genre, region)));
                                }))
                            .toList());
                  } else {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[100],
                      highlightColor: Colors.grey,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => Container(
                          height: 150,
                          margin: EdgeInsets.only(top: 10),
                          child: Card(
                            elevation: 5,
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                    child: Container(
                                      height: 150,
                                      width: 100,
                                    )),
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "                 ",
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "                 ",
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "                 ",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          )),
    );
  }
}
