import 'package:app/features/movie/list/movie_list_controller.dart';
import 'package:design_system/widgets/cards/now_playing_card.dart';
import 'package:flutter/material.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final _controller = MovieListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies List')),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.exception != null) {
            return Center(child: Text(state.exception!.message));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Now Playing', style: Theme.of(context).textTheme.headlineMedium),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = state.data![index];

                      return NowPlayingMovieCard(
                        title: movie.title,
                        rating: movie.voteAverage.toStringAsFixed(2),
                        posterPath: movie.posterPath,
                        overview: movie.overview,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
