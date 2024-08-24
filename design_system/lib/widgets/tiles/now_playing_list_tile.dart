import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/constant/env.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NowPlayingMovieListTile extends StatelessWidget {
  final String title, rating, overview;
  final String? posterPath, releaseDate;
  final List<String>? genres;

  const NowPlayingMovieListTile({
    super.key,
    required this.title,
    required this.rating,
    required this.overview,
    this.posterPath,
    this.genres,
    this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '$imageBaseUrl/$posterPath',
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.white70,
                    highlightColor: Colors.white38,
                    child: Container(
                      width: 90,
                      height: 100,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    child: const Icon(Icons.error),
                    width: 90,
                    height: 100,
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width / 1.8),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Tag(
                          child: Row(
                            children: [
                              Icon(Icons.star_rounded, color: Colors.amber),
                              Text(rating, style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                        if (releaseDate != null)
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Tag(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: 17,
                                    ),
                                    SizedBox(width: 5),
                                    Text(releaseDate.toString(), style: Theme.of(context).textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final Widget child;
  const Tag({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: child,
    );
  }
}

class NowPlayingGridTile extends StatelessWidget {
  final String title, rating, overview;
  final String? posterPath, releaseDate;
  final List<String>? genres;

  const NowPlayingGridTile({
    super.key,
    required this.title,
    required this.rating,
    required this.overview,
    this.posterPath,
    this.releaseDate,
    this.genres,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: '$imageBaseUrl/$posterPath',
            fit: BoxFit.cover,
            width: 160,
            height: 220,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.white70,
              highlightColor: Colors.white38,
              child: Container(
                width: 100,
                height: 150,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              child: const Icon(Icons.error),
              width: 100,
              height: 150,
              color: Colors.grey.shade200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width / 1.8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 17,
            ),
            Text(rating, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
