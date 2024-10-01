import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService{
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SignInUserReq signInUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {


  @override
  Future<Either> signin(SignInUserReq signInUserReq) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserReq.email,
          password: signInUserReq.password);

      return const Right("Sign In Successful");
    }on FirebaseAuthException catch (e){
      String message = '';
      if (e.code == 'user-not-found') {
        message = "Email is wrong or not registered";
      }
      else if (e.code == 'invalid-credential') {
        message = "Wrong email or password. Please check again";
      }
      else if (e.code == "wrong-password"){
        message = "Password cannot be blank";
      }
      else if (e.code == "invalid-email"){
        message = "Email is invalid";
      }
      else{
        message = e.code;
      }
      return left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try{
      var data = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: createUserReq.userName, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').add(
          {
            'name' : createUserReq.fullName,
            'email' : data.user?.email,
          }
      );
      return const Right("Sign Up Successful");
    }on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == "weak password"){
        message = 'Password is too weak';
      }
      if(e.code == "email-already-in-use"){
        message = 'An account is exist with that email';
      }
      return left(message);
    }
  }

}