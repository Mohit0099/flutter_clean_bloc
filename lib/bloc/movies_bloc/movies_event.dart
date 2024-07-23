part of 'movies_bloc.dart';

class MoviesEvent extends Equatable {
  final String userdata;

  MoviesEvent({required this.userdata});

  @override
  List<Object> get props => [];
}

class MoviesFetch extends MoviesEvent {
  MoviesFetch({required super.userdata});
}
