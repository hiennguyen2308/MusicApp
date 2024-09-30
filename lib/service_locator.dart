import 'package:get_it/get_it.dart';
import 'package:music_app/data/repository/auth/auth_repository_impl.dart';
import 'package:music_app/data/source/auth/auth_firebase_service.dart';
import 'package:music_app/domain/responitory/auth/auth.dart';
import 'package:music_app/domain/usecase/auth/signin.dart';
import 'package:music_app/domain/usecase/auth/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies () async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );
}