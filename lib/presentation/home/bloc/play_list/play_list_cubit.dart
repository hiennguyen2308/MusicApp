import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/presentation/home/bloc/play_list/play_list_state.dart';

import '../../../../domain/usecase/song/get_play_list.dart';
import '../../../../service_locator.dart';

class PlayListCubit extends Cubit<PlayListState>{
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async{
    var receivedSong = await sl<GetPlayListUseCase>().call();
    receivedSong.fold(
            (l){
          emit(PlayListLoadFailure());
        },
            (data){
          emit(PlayListLoaded(songs: data));
        }
    );
  }

}