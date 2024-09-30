import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/common/helper/show_snackbar.dart';
import 'package:music_app/common/widget/appbar/basic_appbar.dart';
import 'package:music_app/common/widget/textfield/basic_textfield.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/domain/usecase/auth/signin.dart';
import 'package:music_app/presentation/auth/pages/signup.dart';
import 'package:music_app/presentation/home/pages/home.dart';
import 'package:music_app/service_locator.dart';

import '../../../common/helper/overlay_loading_progress.dart';
import '../../../common/widget/button/basic_app_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not A Member? ",
                style: TextStyle(
                    color: context.isDarkMode? Colors.white : Colors.black,
                    fontSize: 14
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                },
                child: const Text("Register Now",style: TextStyle(fontSize: 14,color: Colors.blue),),)
            ],
          ),
        ),
        appBar: BasicAppbar(
          title: SvgPicture.asset(AppVectors.logo,width: 40,height: 40,),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sign In"
                  ,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                textFieldWidget(context, emailController, "Email"),
                const SizedBox(height: 20,),
                textFieldWidget(context, passwordController, "Password",
                    isVisibility: isVisibility,
                    visibility: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisibility = !isVisibility;
                          });
                        },
                        icon: isVisibility
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined))),
                const SizedBox(height: 20,),
                BasicAppButton(
                    callback: () async {
                      OverlayLoadingProgress.start(context);
                      var result = await sl<SignInUseCase>().call(
                        params: SignInUserReq(email: emailController.text, password: passwordController.text)
                      );
                      OverlayLoadingProgress.stop();
                      result.fold(
                              (l){
                                print(l);
                                showNotifyMessage(context, l);
                              },
                              (r){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const HomeScreen()), (route)=>false);
                              }
                      );
                    },
                    title: "Sign In")

              ],
            ),
          ),
        )
    );
  }
}
