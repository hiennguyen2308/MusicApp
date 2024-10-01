import 'package:get_it/get_it.dart';
import 'package:music_app/data/repository/auth/auth_repository_impl.dart';
import 'package:music_app/data/repository/song/song_repository_impl.dart';
import 'package:music_app/data/source/auth/auth_firebase_service.dart';
import 'package:music_app/domain/repository/song/song.dart';
import 'package:music_app/domain/usecase/auth/signin.dart';
import 'package:music_app/domain/usecase/auth/signup.dart';
import 'package:music_app/domain/usecase/song/get_news_song.dart';
import 'package:music_app/domain/usecase/song/get_play_list.dart';

import 'data/source/song/song_firebase_service.dart';
import 'domain/repository/auth/auth.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies () async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SongRepository>(
      SongRepositoryImpl()
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

  sl.registerSingleton<GetNewsSongUseCase>(
      GetNewsSongUseCase()
  );
  sl.registerSingleton<GetPlayListUseCase>(
      GetPlayListUseCase()
  );
}