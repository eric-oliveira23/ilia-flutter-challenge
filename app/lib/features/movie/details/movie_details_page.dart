import 'package:app/features/movie/details/movie_details_controller.dart';
import 'package:core/constant/env.dart';
import 'package:core/util/context_x.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/common/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieDetailsPage extends StatefulWidget {
  final int id;

  const MovieDetailsPage({super.key, required this.id});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late MovieDetailsController _controller;

  @override
  void initState() {
    _controller = MovieDetailsController(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = 400.0;
    final collapsedHeight = 60.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, state, child) {
              if (state.isLoading) return const Center(child: CircularProgressIndicator());

              if (state.exception != null) return Center(child: Text(state.exception!.message));

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
                    expandedHeight: expandedHeight,
                    collapsedHeight: collapsedHeight,
                    pinned: true,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(.5),
                          shape: const CircleBorder(),
                        ),
                        color: Colors.black,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton.filledTonal(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(.5),
                            shape: const CircleBorder(),
                          ),
                          color: Colors.black,
                          icon: const Icon(Icons.bookmark_outline),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      title: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: context.screenSize.width / 1.5),
                        child: Text(
                          state.data!.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      background: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: expandedHeight - collapsedHeight - 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                                  image: CachedNetworkImageProvider(
                                    '$imageBaseUrl/w500/${state.data!.posterPath}',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.star_rounded, color: Colors.amber),
                                Text(
                                  state.data!.voteAverage.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: state.data?.genres
                                        ?.map((e) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Tag(child: Text(e.name)),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Length', style: Theme.of(context).textTheme.titleMedium),
                                    Text('${state.data!.runtime.toString()} minutes'),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Language', style: Theme.of(context).textTheme.titleMedium),
                                    Text(state.data!.spokenLanguages?.first.name ?? ''),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Adult', style: Theme.of(context).textTheme.titleMedium),
                                    Text('${state.data!.adult ? 'Yes' : 'No'}'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(state.data!.title, style: Theme.of(context).textTheme.headlineMedium),
                            Text(state.data!.overview, style: Theme.of(context).textTheme.bodyMedium),
                            Text(state.data!.releaseDate, style: Theme.of(context).textTheme.bodySmall),
                            Text(state.data!.voteAverage.toStringAsFixed(2),
                                style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(height: 1000),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
