import 'package:core/client/http_client.dart';
import 'package:core/client/http_client_impl.dart';
import 'package:core/core.dart';
import 'package:service/movie/repository/remote/now_playing/now_playing_repository.dart';
import 'package:service/movie/repository/remote/now_playing/now_playing_repository_impl.dart';

final getIt = GetIt.instance;

void setupInjectors() {
  // repositories
  getIt.registerFactory<NowPlayingRepository>(() => NowPlayingRepositoryImpl());

  // data sources
  getIt.registerFactory<HttpClient>(() => HttpClientImpl());
}
