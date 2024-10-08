import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/common/helper/strip_VN.dart';
import 'package:music_app/core/configs/constant/app_url.dart';
import 'package:music_app/presentation/home/bloc/news_song/news_song_cubit.dart';
import 'package:music_app/presentation/home/bloc/news_song/news_song_state.dart';

import '../../../core/configs/theme/app_color.dart';
import '../../../domain/entities/song/song.dart';
import '../../song_player/pages/song_player.dart';

class NewsSongs extends StatefulWidget {
  const NewsSongs({super.key});

  @override
  State<NewsSongs> createState() => _NewsSongsState();
}

class _NewsSongsState extends State<NewsSongs> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=>NewsSongCubit()..getNewsSong(),
      child: BlocBuilder<NewsSongCubit,NewsSongState>(
        builder: (BuildContext context, NewsSongState state) {
          if(state is NewsSongLoading){
            return Container();
          }
          if(state is NewsSongLoaded){
            return _songs(state.songs);
          }
           return const Text("fail");
        },),
    );
  }

  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context)
                    => SongPlayerScreen(
                      songEntity: songs[index],
                    )
                )
            );
          },
          child:SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${AppURLs.thumbnailFirestorage}${stripVN(songs[index].title!)}-${stripVN(songs[index].artist!).replaceAll(",", "")}.jpg?${AppURLs.mediaAlt}'
                          )
                      )
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 40,
                      width: 40,
                      transform: Matrix4.translationValues(10, 10, 0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode ?  AppColors.darkGrey : const Color(0xffE6E6E6)
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              FittedBox(
                child: Text(
                  songs[index].title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),
                ),
              ) ,
              const SizedBox(height: 5,),
              Text(
                songs[index].artist!,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                ),
              )
            ],
          ),
        ),
        );
        },
        separatorBuilder: (context, index)=> const SizedBox(width: 14,),
        itemCount: songs.length);
  }
}
