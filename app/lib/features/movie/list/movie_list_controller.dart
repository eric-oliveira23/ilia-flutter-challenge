import 'package:app/features/movie/details/movie_details_page.dart';
import 'package:app/features/movie/list/movie_list_states.dart';
import 'package:core/controller/base_controller.dart';
import 'package:core/core.dart';
import 'package:core/util/context_x.dart';
import 'package:flutter/material.dart';
import 'package:service/movie/repository/remote/now_playing/now_playing_repository.dart';

class MovieListController extends BaseController<MovieListState> {
  final repository = GetIt.instance<NowPlayingRepository>();

  MovieListController() : super(MovieListState(isLoading: true)) {
    fetchMovies();
  }
  Future<void> fetchMovies({bool loadMore = false}) async {
    if (loadMore && !state.hasMore) return;

    if (loadMore) {
      update(state.copyWith(pageLoading: true));
    } else {
      update(state.copyWith(isLoading: true));
    }

    final result = await repository.fetch(page: state.currentPage);

    result.fold(
      (error) {
        update(state.copyWith(exception: error, isLoading: false, pageLoading: false));
      },
      (success) {
        if (success.isEmpty) {
          state.copyWith(hasMore: false);
        } else {
          final newData = loadMore ? [...?state.data, ...success] : success;
          update(
            state.copyWith(
              isLoading: false,
              pageLoading: false,
              data: newData,
              currentPage: state.currentPage + 1,
            ),
          );
        }
      },
    );
  }

  void changeListType() => update(
        state.copyWith(
          listType: state.listType == MovieListType.list ? MovieListType.grid : MovieListType.list,
        ),
      );

  void onMovieTap(int id, BuildContext context) => context.toView(
        MovieDetailsPage(id: id),
      );
}

enum MovieListType { list, grid }
