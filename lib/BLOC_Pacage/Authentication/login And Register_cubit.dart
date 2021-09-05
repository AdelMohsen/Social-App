import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_store_models.dart';
import 'Login And Register_State.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  Icon changeIcon = Icon(Icons.visibility);

  showPassword() {
    isVisible = !isVisible;
    changeIcon = isVisible
        ? Icon(
            Icons.visibility,
            color: Colors.white,
          )
        : Icon(
            Icons.visibility_off,
            color: Colors.white,
          );
    emit(ShowPasswordState());
  }

  //LOGIN_BLOC
  loginSignIn({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  //Registeration_Bloc
  registerCreate({
    required String email,
    required String password,
    required String userName,
    required String phone,
    bool isEmailVerification = false,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userStoreData(
          userName: userName,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          isEmailVerification: isEmailVerification);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  userStoreData(
      {required String userName,
      required String email,
      required String phone,
      required String uId,
      required isEmailVerification}) {
    UsersModel usersModel = UsersModel(
        userName: userName,
        email: email,
        phone: phone,
        uId: uId,
        bio: 'write your bio...',
        profileImage:
            'https://st.depositphotos.com/1008939/i/600/depositphotos_18807295-stock-photo-portrait-of-handsome-man.jpg',
        coverImage:
            'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        isEmailVerification: isEmailVerification);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(usersModel.toMap())
        .then((value) {
      emit(UserStoreSuccessState(usersModel.uId));
    }).catchError((error) {
      print(error.toString());
      emit(UserStoreErrorState(error.toString()));
    });
  }
}
