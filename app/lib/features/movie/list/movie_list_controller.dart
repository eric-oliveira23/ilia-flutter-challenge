import 'package:app/features/movie/list/movie_list_states.dart';
import 'package:core/controller/base_controller.dart';
import 'package:core/core.dart';
import 'package:service/movie/repository/remote/now_playing/now_playing_repository.dart';

class MovieListController extends BaseController<MovieListState> {
  final repository = GetIt.instance<NowPlayingRepository>();

  MovieListController() : super(MovieListState(isLoading: true)) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final result = await repository.fetch(page: 1);

    result.fold(
      (error) {
        update(state.copyWith(exception: error, isLoading: false));
      },
      (success) => update(
        state.copyWith(
          isLoading: false,
          data: success,
        ),
      ),
    );
  }
}
