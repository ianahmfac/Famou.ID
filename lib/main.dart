import 'package:flutix/bloc/blocs.dart';
import 'package:flutix/services/services.dart';
import 'package:flutix/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamProvider.value(
      value: AuthService.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PageBloc()),
          BlocProvider(create: (context) => UserBloc()),
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => MovieBloc()..add(FetchMovies())),
          BlocProvider(
              create: (context) =>
                  UpcomingmovieBloc()..add(FetchUpcomingMovies())),
          BlocProvider(
            create: (context) => TicketBloc(),
          )
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) => GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus.unfocus();
            },
            child: MaterialApp(
              theme: themeState.themeData,
              title: "Famou.ID",
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          ),
        ),
      ),
    );
  }
}
