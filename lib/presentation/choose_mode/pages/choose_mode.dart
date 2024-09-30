import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/presentation/auth/pages/signup_or_signin.dart';
import '../../../../common/widget/button/basic_app_button.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/configs/theme/app_color.dart';
import '../bloc/theme_cubit.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  bool isChoose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppImages.chooseModeBG)
              )
          ),
          child: Column(
            children: [
              SafeArea(child: SvgPicture.asset(AppVectors.logo)),
              const Spacer(),
              const Text("Choose Mode",style: TextStyle(
                fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18
              ),),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          print("dark mode");
                        },
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: !context.isDarkMode ? const Color(0xff30393C).withOpacity(0.5) : Colors.grey,
                                  shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset(
                                AppVectors.moon,
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text(
                        'Dark Mode',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.grey
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 40,),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                          print("light mode");
                        },
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: context.isDarkMode ? const Color(0xff30393C).withOpacity(0.5) : Colors.grey,
                                  shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset(
                                AppVectors.sun,
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text(
                        'Light Mode',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.grey
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              BasicAppButton(
                  callback: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupOrSigninScreen()));
                  }, title: "Continue"),
              const SizedBox(height: 80,),
            ],
          ),
        )
    );
  }
}
