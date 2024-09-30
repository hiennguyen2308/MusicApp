import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/common/widget/appbar/basic_appbar.dart';
import 'package:music_app/common/widget/button/basic_app_button.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_color.dart';
import 'package:music_app/presentation/auth/pages/signin.dart';
import 'package:music_app/presentation/auth/pages/signup.dart';

class SignupOrSigninScreen extends StatefulWidget {
  const SignupOrSigninScreen({super.key});

  @override
  State<SignupOrSigninScreen> createState() => _SignupOrSigninScreenState();
}

class _SignupOrSigninScreenState extends State<SignupOrSigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(height: 40,),
                  FittedBox(
                    child: Text(
                      'Enjoy Listening To Music',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.isDarkMode ? Colors.white :Colors.black,
                          fontSize: 26
                      ),
                    ),
                  ),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                          child: BasicAppButton(
                            callback: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                            },
                            title: 'Register',
                          )
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                          },
                          child: Text("Sign in",style: TextStyle(
                            color: context.isDarkMode ?Colors.white:Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:16
                          ),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
