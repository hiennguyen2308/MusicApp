import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  String ? title;
  String ? artist;
  num ? duration;
  Timestamp ? releaseDate;

  SongEntity(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate});

  SongEntity.fromJson(Map<String,dynamic> data){
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
  }
}