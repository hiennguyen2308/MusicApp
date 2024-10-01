import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:music_app/data/models/song/song.dart';
import 'package:music_app/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future <Either> getNewsSong();
}

class SongFirebaseServiceImpl extends SongFirebaseService{
  @override
  Future<Either> getNewsSong() async{
    try{
      List<SongEntity> songs=[];
      var data = await FirebaseFirestore.instance.collection("Songs").orderBy("releaseDate",descending: true).get();
      if (kDebugMode) {
        print("loading data");
        print(data);
      }
      for(var element in data.docs){
        print("fetch");
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
        print(songs.length);
      }
      return Right(songs);
    }catch(e){
      print(e);
      return left(e);
    }
  }

}