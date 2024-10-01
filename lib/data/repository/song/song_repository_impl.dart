import 'package:dartz/dartz.dart';
import 'package:music_app/data/source/song/song_firebase_service.dart';
import 'package:music_app/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSong() async{
    return await sl<SongFirebaseService>().getNewsSong();
  }

}