import 'package:core/type/output.dart';
import 'package:service/movie/entities/movie_entity.dart';

abstract class NowPlayingRepository {
  Future<Output<List<MovieEntity>>> fetch({required int page});
}
