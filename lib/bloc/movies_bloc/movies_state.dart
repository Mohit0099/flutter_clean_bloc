part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  MoviesState({
    this.userdata = "",
    required this.moviesList,
  });

  final ApiResponse<MovieListModel> moviesList;
  final String userdata;

  MoviesState copyWith(
      {ApiResponse<MovieListModel>? moviesList, String? userdata}) {
    return MoviesState(
        moviesList: moviesList ?? this.moviesList,
        userdata: userdata ?? this.userdata);
  }

  @override
  List<Object?> get props => [moviesList, userdata];
}
