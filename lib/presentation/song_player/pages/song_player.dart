import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/common/widget/appbar/basic_appbar.dart';
import 'package:music_app/core/configs/theme/app_color.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:music_app/presentation/song_player/bloc/song_player_state.dart';

import '../../../common/helper/strip_VN.dart';
import '../../../core/configs/constant/app_url.dart';

class SongPlayerScreen extends StatefulWidget {
  final SongEntity songEntity;
  const SongPlayerScreen({super.key, required this.songEntity});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
            "Now playing",
          style: TextStyle(
            color: context.isDarkMode ? Colors.white :Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        action: IconButton(
          onPressed: (){},
          icon: Icon(Icons.more_vert_outlined,color: context.isDarkMode ? Colors.white :Colors.black,),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
            '${AppURLs.songFirestorage}${stripVN(widget.songEntity.title!).replaceAll(" ", "")}-${stripVN(widget.songEntity.artist!).replaceAll(",", "")}.mp3?${AppURLs.mediaAlt}'
        ),
        child: SingleChildScrollView(
          child: Builder(
            builder: (context){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    thumbnailsSong(),
                    const SizedBox(height: 20,),
                    detailSong(),
                    _songPlayer(context)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget thumbnailsSong(){
    return Container(
      height: MediaQuery.sizeOf(context).height/2,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppURLs.thumbnailFirestorage}${stripVN(widget.songEntity.title!)}-${stripVN(widget.songEntity.artist!).replaceAll(",", "")}.jpg?${AppURLs.mediaAlt}'
          )
        ),
        borderRadius: BorderRadius.circular(30)
      ),
    );
  }

  Widget detailSong(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.songEntity.title!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: context.isDarkMode ? Colors.white : Colors.black),
            ),
            Text(
              widget.songEntity.artist!,
              style: TextStyle(
                  fontSize: 20,
                  color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555)),
            )
          ],
        ),
        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline_outlined,size: 35,))
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context, state) {
        if(state is SongPlayerLoading){
          return const CircularProgressIndicator();
        }
        if(state is SongPlayerLoaded) {

          return Column(
            children: [
              Slider(
                  value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble() ,
                  onChanged: (value){
                    context.read<SongPlayerCubit>().seekSong(Duration(seconds: value.toInt()));
                  }
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songPosition
                      )
                  ),

                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songDuration
                      )
                  )
                ],
              ),
              const SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary
                  ),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                  ),
                ),
              )
            ],
          );
        }

        return Container(child: Text("Fail"),);
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}
