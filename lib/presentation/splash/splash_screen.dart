
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/presentation/home/pages/home.dart';
import '../../firebase_options.dart';
import '../intro/pages/get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> redirect() async {
    initializeFlutterFire();
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
              user != null ?
              const HomeScreen() :
              const GetStartedScreen()));
    });
  }

  void initializeFlutterFire() async {
    try {
      if (kIsWeb) {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      }
      else {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
        user = FirebaseAuth.instance.currentUser;
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // throw Exception(e);
      print("dasd ${e.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppVectors.logo),
      ),
    );
  }
}
