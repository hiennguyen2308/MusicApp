import 'package:dartz/dartz.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/data/source/auth/auth_firebase_service.dart';
import 'package:music_app/service_locator.dart';

import '../../../domain/repository/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    return await sl<AuthFirebaseService>().signin(signInUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq ? createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq!);
  }

}