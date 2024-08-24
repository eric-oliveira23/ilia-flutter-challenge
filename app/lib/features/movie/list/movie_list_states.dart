import 'package:core/error/base_exception.dart';
import 'package:core/state/base_state.dart';
import 'package:service/movie/entities/movie_entity.dart';

class MovieListState extends BaseState<List<MovieEntity>> {
  MovieListState({
    bool isLoading = false,
    BaseException? exception,
    List<MovieEntity>? movies,
  }) : super(
          isLoading: isLoading,
          exception: exception,
          data: movies,
        );

  @override
  MovieListState copyWith({
    bool? isLoading,
    List<MovieEntity>? data,
    BaseException? exception,
  }) {
    return MovieListState(
      isLoading: isLoading ?? this.isLoading,
      movies: data ?? this.data,
      exception: exception ?? this.exception,
    );
  }
}
