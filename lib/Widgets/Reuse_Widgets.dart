import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/Presentation_Layer/Login%20And%20Register%20Screens/LoginScreen.dart';
import 'package:social_app/Widgets/constant.dart';

import '../Cahche_helper.dart';

navigateTo(context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

navigateAndRemove(context, Widget widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

enum toastState { SUCCESS, ERROR, WARNING }

showToast({
  required String msg,
  required toastState state,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: chooseToastColor(state),
      fontSize: 20.0,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
    );

Color? chooseToastColor(toastState state) {
  Color color;
  switch (state) {
    case toastState.SUCCESS:
      color = Colors.green;
      break;
    case toastState.ERROR:
      color = Colors.red;
      break;
    case toastState.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

logOut(context) => MaterialButton(
      onPressed: () {
        CacheHelper.removeData(key: 'uId');
        navigateAndRemove(context, LoginScreen());
      },
      child: Text('LOG OUT'),
    );

defaultTextFormField(
        {context,
        required String labelText,
        required Widget suffexIcon,
        required String? Function(String?)? validator,
        required int maxLines,
        required TextEditingController controller,
        required TextInputType keyBoardType,
        required int maxLength}) =>
    TextFormField(
      style:Theme.of(context).textTheme.bodyText1,
      keyboardType: keyBoardType,
      maxLength: maxLength,
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: MyColor.black,
          ),
        ),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        labelStyle: Theme.of(context).textTheme.bodyText1,
        prefixIcon: suffexIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
      ),
    );
