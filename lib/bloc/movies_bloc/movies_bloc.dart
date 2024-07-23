import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_coding/data/response/api_response.dart';
import 'package:bloc_clean_coding/data/response/response.dart';
import 'package:bloc_clean_coding/repository/movies_api/movies_api_repository.dart';
import 'package:bloc_clean_coding/services/storage/local_storage.dart';
import 'package:equatable/equatable.dart';

import '../../model/movie_list/movie_list_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesApiRepository moviesApiRepository;
  String? userData;
  final LocalStorage _localStorage = LocalStorage();
  MoviesBloc({required this.moviesApiRepository})
      : super(MoviesState(
          moviesList: ApiResponse.loading(),
        )) {
    on<MoviesFetch>(fetchMoviesListApi);
  }

  Future<void> fetchMoviesListApi(
      MoviesFetch event, Emitter<MoviesState> emit) async {
    userData = await _localStorage.readValue('tokennew');
    await moviesApiRepository.fetchMoviesList().then((response) {
      emit(state.copyWith(
          moviesList: ApiResponse.completed(response), userdata: userData));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        moviesList: ApiResponse.error(error.toString()),
      ));
    });
  }
}
