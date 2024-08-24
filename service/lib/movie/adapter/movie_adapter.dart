import 'package:service/movie/entities/movie_entity.dart';

class MovieAdapter {
  static MovieEntity fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'].cast<int>(),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  static Map<String, dynamic> toJson({required MovieEntity entity}) {
    return {
      'adult': entity.adult,
      'backdrop_path': entity.backdropPath,
      'genre_ids': entity.genreIds,
      'id': entity.id,
      'original_language': entity.originalLanguage,
      'original_title': entity.originalTitle,
      'overview': entity.overview,
      'popularity': entity.popularity,
      'poster_path': entity.posterPath,
      'release_date': entity.releaseDate,
      'title': entity.title,
      'video': entity.video,
      'vote_average': entity.voteAverage,
      'vote_count': entity.voteCount,
    };
  }
}
