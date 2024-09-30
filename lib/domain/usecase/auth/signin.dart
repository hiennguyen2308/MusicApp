import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/domain/responitory/auth/auth.dart';

import '../../../service_locator.dart';

class SignInUseCase implements Usecase<Either,SignInUserReq>{
  @override
  Future<Either> call({SignInUserReq ? params}) {

    return sl<AuthRepository>().signin(params!);
  }

}