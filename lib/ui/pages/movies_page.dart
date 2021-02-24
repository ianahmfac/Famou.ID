part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          floating: true,
          expandedHeight: 150,
          collapsedHeight: 150,
          flexibleSpace: headerMovies(),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            nowPlayingCarousel(),
            comingSoonMovies(),
            browseMovie(context),
            promoBanner(),
            SizedBox(height: 20)
          ]),
        )
      ],
    );
  }

  Column promoBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Special Promo For You", bannerPromo: true),
        Column(
          children: dummyPromos.map((e) => PromoCard(e)).toList(),
        ),
      ],
    );
  }

  Column browseMovie(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Your Movie Genres"),
        BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
          if (userState is UserLoaded) {
            return Container(
                height: 90,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    userState.user.selectedGenres.length,
                    (index) => Container(
                      margin: EdgeInsets.fromLTRB(
                          (index == 0) ? defaultMargin : 0,
                          0,
                          (index == userState.user.selectedGenres.length - 1)
                              ? defaultMargin
                              : 16,
                          0),
                      child: BrowseButton(
                        userState.user.selectedGenres[index],
                        onTap: () {
                          String genre = userState.user.selectedGenres[index];
                          String region = userState.user.selectedLanguage;
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieGenrePage(genre, region));
                        },
                      ),
                    ),
                  ),
                ));
          } else {
            return SpinKitWave(color: mainColor);
          }
        })
      ],
    );
  }

  Widget nowPlayingCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Now Playing"),
        BlocBuilder<MovieBloc, MovieState>(builder: (context, movieState) {
          if (movieState is MovieLoaded) {
            List<Movie> movies = movieState.movies;
            return Container(
                child: CarouselSlider(
              height: 180,
              initialPage: 0,
              enlargeCenterPage: true,
              reverse: false,
              items: movies
                  .map((movie) => MovieCard(
                        movie,
                        onTap: () {
                          context.bloc<PageBloc>().add(
                              GoToMovieDetailPage(movie, true, GoToMainPage()));
                        },
                      ))
                  .toList(),
            ));
          } else {
            return SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            );
          }
        })
      ],
    );
  }

  Widget comingSoonMovies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Coming Soon"),
        SizedBox(
          height: 170,
          child: BlocBuilder<UpcomingmovieBloc, UpcomingmovieState>(
              builder: (context, movieState) {
            if (movieState is UpcomingMovieLoaded) {
              List<Movie> movies = movieState.movies;
              List<Movie> currentMovies = movies
                  .where((element) => element.voteAverage == 0.0)
                  .toList();
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: currentMovies.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(
                    left: (index == 0) ? defaultMargin : 0,
                    right: (index == currentMovies.length - 1)
                        ? defaultMargin
                        : 16,
                  ),
                  child: MovieCard(currentMovies[index], isNowPlaying: false,
                      onTap: () {
                    context.bloc<PageBloc>().add(GoToMovieDetailPage(
                        currentMovies[index], false, GoToMainPage()));
                  }),
                ),
              );
            } else {
              return SizedBox(
                height: 170,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      height: 170,
                      width: 120,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  Container titleText(String title, {bool bannerPromo = false}) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          defaultMargin, (bannerPromo) ? 0 : 30, defaultMargin, 12),
      child: Text(title,
          style: blackTextFont.copyWith(
              color: accentColor1, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget headerMovies() {
    return Container(
      decoration: BoxDecoration(
        color: accentColor1,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(defaultMargin, 45, defaultMargin, 0),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            if (imageFileToUpload != null) {
              uploadImage(imageFileToUpload).then((downloadURL) {
                imageFileToUpload = null;
                context
                    .bloc<UserBloc>()
                    .add(UpdateUserData(profileImage: downloadURL));
              });
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/h_logo_secondary.png",
                  height: 30,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Stack(
                        children: [
                          SpinKitFadingCircle(
                            color: accentColor2,
                            size: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShowImage(state.user.profilePicture),
                                  ));
                            },
                            child: Hero(
                              tag: "image",
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: (state.user.profilePicture != "")
                                          ? NetworkImage(
                                              state.user.profilePicture)
                                          : AssetImage("assets/user_pic.png"),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToWalletPage(GoToMainPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: whiteTextFont.copyWith(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: "id_ID",
                                  decimalDigits: 2,
                                  symbol: "Rp",
                                ).format(state.user.balance),
                                style: yellowNumberFont.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.cog,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        context.bloc<PageBloc>().add(GoToSettingsPage());
                      },
                    )
                  ],
                ),
              ],
            );
          } else {
            return SpinKitFadingCircle(
              color: accentColor2,
              size: 50,
            );
          }
        },
      ),
    );
  }
}
