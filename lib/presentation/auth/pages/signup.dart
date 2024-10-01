import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/helper/is_dark_mode.dart';
import 'package:music_app/common/widget/appbar/basic_appbar.dart';
import 'package:music_app/common/widget/button/basic_app_button.dart';
import 'package:music_app/common/widget/textfield/basic_textfield.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/domain/usecase/auth/signup.dart';
import 'package:music_app/presentation/auth/pages/signin.dart';

import '../../../common/helper/overlay_loading_progress.dart';
import '../../../service_locator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
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
            Text("Do you have an account?",
              style: TextStyle(
                color: context.isDarkMode? Colors.white : Colors.black,
                fontSize: 14
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
              },
              child: const Text("Sign in",style: TextStyle(fontSize: 14,color: Colors.blue),),)
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
                "Register"
                ,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50,),
              textFieldWidget(context, nameController, "Full Name",),
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
                    var result = await sl<SignUpUseCase>().call(
                      params: CreateUserReq(
                          fullName: nameController.text,
                          userName: emailController.text,
                          password: passwordController.text)
                    );
                    OverlayLoadingProgress.stop();
                      result.fold(
                              (l) {
                                print(l);
                                var message = SnackBar(content: Text(l,style: const TextStyle(color: Colors.black),));
                                ScaffoldMessenger.of(context).showSnackBar(message);
                              },
                              (r) {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen()), (route)=>false);
                              }
                      );
                    },
                  title: "Create Account")
          
              ],
          ),
        ),
      )
    );
  }
}




