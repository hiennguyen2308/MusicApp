import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/usecase/song/get_news_song.dart';
import 'package:music_app/presentation/home/bloc/news_song/news_song_state.dart';

import '../../../../service_locator.dart';

class NewsSongCubit extends Cubit<NewsSongState>{
  NewsSongCubit() : super(NewsSongLoading());

  Future<void> getNewsSong() async{
    var receivedSong = await sl<GetNewsSongUseCase>().call();
    receivedSong.fold(
            (l){
              emit(NewSongLoadFailure());
            },
            (data){
              emit(NewsSongLoaded(songs: data));
            }
    );
  }

}