class MovieEntity {
  final String? posterPath;
  final String? backdropPath;
  final List<int>? genreIds;
  final bool adult;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieEntity({
    required this.adult,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.posterPath,
    this.genreIds,
    this.backdropPath,
  });
}
