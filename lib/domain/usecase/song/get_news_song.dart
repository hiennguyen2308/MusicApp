import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

class GetNewsSongUseCase implements Usecase<Either,dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<SongRepository>().getNewsSong();
  }

}