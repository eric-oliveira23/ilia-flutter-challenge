import 'package:app/features/movie/details/movie_details_state.dart';
import 'package:core/controller/base_controller.dart';
import 'package:core/core.dart';
import 'package:service/movie/repository/remote/details/details_repository.dart';

class MovieDetailsController extends BaseController<MovieDetailsState> {
  final int id;

  final repository = GetIt.instance<MovieDetailsRepository>();

  MovieDetailsController({required int this.id}) : super(MovieDetailsState(isLoading: true)) {
    fetchMovie();
  }
  Future<void> fetchMovie() async {
    final result = await repository.fetch(id: id);

    result.fold(
      (error) {
        update(state.copyWith(exception: error, isLoading: false));
      },
      (success) {
        update(
          state.copyWith(
            isLoading: false,
            data: success,
          ),
        );
      },
    );
  }
}
