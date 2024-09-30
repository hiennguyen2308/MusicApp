import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/widget/button/basic_app_button.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';

import '../../../../core/configs/theme/app_color.dart';
import '../../choose_mode/pages/choose_mode.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
                image: AssetImage(AppImages.introBG)
            )
        ),
        child: Column(
          children: [
            SafeArea(child: SvgPicture.asset(AppVectors.logo)),
            const Spacer(),
            const Text(
              'Enjoy Listening To Music',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18
              ),
            ),
            const SizedBox(height: 21,),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                  fontSize: 13
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            BasicAppButton(
                callback: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChooseModeScreen()));
            }, title: "Get Started"),
            const SizedBox(height: 80,),
          ],
        ),
      )
    );
  }
}
