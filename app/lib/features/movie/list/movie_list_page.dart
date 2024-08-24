import 'package:app/features/movie/list/movie_list_controller.dart';
import 'package:core/core.dart';
import 'package:design_system/widgets/cards/now_playing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:service/movie/entities/movie_entity.dart';
import 'package:service/movie/entities/movie_list_type.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final _controller = MovieListController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 20) {
      if (!_controller.state.pageLoading) {
        _controller.fetchMovies(loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        actions: [
          IconButton(
            onPressed: () => setState(() => _controller.changeListType()),
            icon: Icon(_controller.state.listType == MovieListType.list ? Icons.grid_view : Icons.list),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, state, child) {
          if (state.isLoading) return const Center(child: CircularProgressIndicator());

          if (state.exception != null) return Center(child: Text(state.exception!.message));

          return SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Now Playing', style: Theme.of(context).textTheme.headlineMedium),
                  AnimatedSwitcher(
                      duration: Durations.medium1,
                      child: state.listType == MovieListType.list
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final MovieEntity movie = state.data![index];
                                return NowPlayingMovieTile(
                                  title: movie.title,
                                  rating: movie.voteAverage.toStringAsFixed(2),
                                  posterPath: movie.posterPath,
                                  overview: movie.overview,
                                  releaseDate: DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(movie.releaseDate),
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .6,
                              ),
                              itemCount: state.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final MovieEntity movie = state.data![index];
                                return NowPlayingGridTile(
                                  title: movie.title,
                                  rating: movie.voteAverage.toStringAsFixed(2),
                                  posterPath: movie.posterPath,
                                  overview: movie.overview,
                                  releaseDate: DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(movie.releaseDate),
                                  ),
                                );
                              },
                            )),
                  if (state.pageLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
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
