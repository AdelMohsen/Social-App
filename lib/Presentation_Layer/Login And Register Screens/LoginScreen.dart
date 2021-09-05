import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/BLOC_Pacage/Authentication/login%20And%20Register_cubit.dart';
import 'package:social_app/BLOC_Pacage/Authentication/Login%20And%20Register_State.dart';
import 'package:social_app/Presentation_Layer/Global_layout/Global_Main_Layout.dart';
import 'package:social_app/Presentation_Layer/Login%20And%20Register%20Screens/RegisterScreen.dart';
import 'package:social_app/Widgets/Reuse_Widgets.dart';
import 'package:social_app/Widgets/constant.dart';
import '../../Cahche_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            )),
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                CacheHelper.saveData(key: 'uId', value: state.uId)
                    .then((value) {
                  uId = state.uId;
                });
                navigateAndRemove(context, GlobalLayout());
              }
              if(state is LoginErrorState){
                showToast(msg: state.error.toString(), state: toastState.ERROR);
              }
            },
            builder: (context, state) {
              var cubit = LoginCubit.get(context);
              return loginBuilder(emailController, passwordController,
                  globalKey, context, cubit,state);
            },
          ),
        ),
      ),
    );
  }
}

loginBuilder(TextEditingController emailController,
    TextEditingController passwordController,
    GlobalKey<FormState> globalKey,
    context,
    LoginCubit cubit,
    LoginState state) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: globalKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                AutoSizeText(
                  'GLOBAL',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  height: 5.0,
                ),
                AutoSizeText(
                  'login to communicate with your friends',
                  style: TextStyle(
                      color: Colors.cyanAccent[450],
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    validator: (String? value) =>
                    value!.isEmpty ? 'email must not be empty' : null,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    obscureText: cubit.isVisible,
                    validator: (String? value) =>
                    value!.isEmpty ? 'email must not be empty' : null,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: cubit.changeIcon,
                          onPressed: () {
                            cubit.showPassword();
                          },
                        ))),
                SizedBox(
                  height: 10,
                ),
                Conditional.single(context: context,
                  conditionBuilder: (context)=> state is! LoginLoadingState ,
                  widgetBuilder:(context)=> MaterialButton(
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        cubit.loginSignIn(
                            email: emailController.text,
                            password: passwordController.text);
                      } else {
                        showToast(msg: 'enter details', state: toastState.ERROR);
                      }
                    },
                    child: AutoSizeText(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.transparent,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2.2)),
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    height: 50.0,
                    elevation: 4,
                    highlightColor: Colors.indigoAccent,
                  ),
                  fallbackBuilder: (context)=>Center(child: CircularProgressIndicator())
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "Don't have an account?",
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, RegisterScreen());
                        },
                        child: AutoSizeText(
                          "REGISTER NOW!!",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

