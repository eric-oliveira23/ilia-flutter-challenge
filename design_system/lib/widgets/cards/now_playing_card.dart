import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/constant/env.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NowPlayingMovieCard extends StatelessWidget {
  final String title, rating, posterPath, overview;
  final List<String>? genres;

  const NowPlayingMovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.posterPath,
    required this.overview,
    this.genres,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '$imageBaseUrl/$posterPath',
                  fit: BoxFit.cover,
                  width: 110,
                  height: 140,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.white70,
                    highlightColor: Colors.white38,
                    child: Container(
                      width: 50,
                      height: 50,
                    ),
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
                      constraints: BoxConstraints(maxWidth: size.width / 1.7),
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
                        Icon(Icons.star, color: Colors.amber),
                        Text(rating, style: Theme.of(context).textTheme.titleMedium),
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

    // ListTile(
    //   minTileHeight: 70,
    //   trailing: Text(rating),
    //   leading: CachedNetworkImage(
    //     imageUrl: '$imageBaseUrl/$posterPath',
    //     fit: BoxFit.cover,
    //     width: 70,
    //     height: 130,
    //     placeholder: (context, url) => Shimmer.fromColors(
    //       baseColor: Colors.white70,
    //       highlightColor: Colors.white38,
    //       child: Container(
    //         width: 50,
    //         height: 50,
    //       ),
    //     ),
    //   ),
    //   title: Text(title),
    // );
  }
}
