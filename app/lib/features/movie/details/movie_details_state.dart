import 'package:core/error/base_exception.dart';
import 'package:core/state/base_state.dart';
import 'package:service/movie/entities/movie_entity.dart';

class MovieDetailsState extends BaseState<MovieEntity> {
  MovieDetailsState({
    bool isLoading = false,
    BaseException? exception,
    MovieEntity? movie,
  }) : super(
          isLoading: isLoading,
          exception: exception,
          data: movie,
        );

  @override
  MovieDetailsState copyWith({
    bool? isLoading,
    MovieEntity? data,
    BaseException? exception,
  }) {
    return MovieDetailsState(
      isLoading: isLoading ?? this.isLoading,
      movie: data ?? this.data,
      exception: exception ?? this.exception,
    );
  }
}
