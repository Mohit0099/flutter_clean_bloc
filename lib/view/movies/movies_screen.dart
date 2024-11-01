import 'dart:developer';

import 'package:bloc_clean_coding/bloc/movies_bloc/movies_bloc.dart';
import 'package:bloc_clean_coding/data/response/response.dart';
import 'package:bloc_clean_coding/data/response/status.dart';
import 'package:bloc_clean_coding/services/session_manager/session_controller.dart';
import 'package:bloc_clean_coding/services/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configs/components/network_image_widget.dart';
import '../../main.dart';
import 'widget/widgets.dart';

/// A widget representing the screen displaying a list of movies.
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _HomeViewState();
}

/// The state of the [MoviesScreen] widget.
class _HomeViewState extends State<MoviesScreen> {
  late MoviesBloc moviesBloc;
  final LocalStorage _localStorage = LocalStorage();
  @override
  void initState() {
    super.initState();
    read();
    moviesBloc = MoviesBloc(moviesApiRepository: getIt());
    // Dispatches the [PostFetched] event to trigger fetching movies data
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  String? userData;

  read() async {
    userData = await _localStorage.readValue('tokennew');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.popularShows),
        actions: const [
          LogoutButtonWidget(), // Widget for logout button
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: BlocProvider(
        create: (_) =>
            moviesBloc..add(MoviesFetch(userdata: userData.toString())),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: (previous, current) =>
              previous.moviesList != current.moviesList,
          builder: (BuildContext context, state) {
            switch (state.moviesList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const Text("cenio"); // Widget for displaying error state
              case Status.completed:
                if (state.moviesList.data == null) {
                  // Widget for displaying no data found message
                  return Text(AppLocalizations.of(context)!.noDataFound);
                }
                final movieList = state.moviesList.data!;

                return Column(
                  children: [
                    Text(state.userdata.toString()),
                    Text(SessionController.user.token.toString()),
                    Expanded(
                      child: ListView.builder(
                          itemCount: movieList.tvShow.length,
                          itemBuilder: (context, index) {
                            final tvShow = movieList.tvShow[index];
                            return Card(
                              child: ListTile(
                                leading: NetworkImageWidget(
                                  borderRadius: 5,
                                  imageUrl:
                                      tvShow.imageThumbnailPath.toString(),
                                ), // Widget for displaying network image
                                title: Text(tvShow.name
                                    .toString()), // Title of the movie
                                subtitle: Text(tvShow.network
                                    .toString()), // Network of the movie
                                trailing: Text(tvShow.status.toString()),
                                // Status of the movie
                              ),
                            );
                          }),
                    ),
                  ],
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
