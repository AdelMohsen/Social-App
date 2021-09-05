import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/Widgets/constant.dart';
import 'Cahche_helper.dart';
import 'Presentation_Layer/Global_layout/Global_Main_Layout.dart';
import 'Presentation_Layer/Login And Register Screens/LoginScreen.dart';
import 'ob_server.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: MyColor.white,
      systemNavigationBarIconBrightness: Brightness.dark));

  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget startWidget = LoginScreen();
  uId = CacheHelper.readData(key: 'uId');
  Bloc.observer = MyBlocObserver();
  uId == null ? startWidget = LoginScreen() : startWidget = GlobalLayout();
  //print(uId.toString());
  runApp(GlobalApp(startWidget));
}

class GlobalApp extends StatelessWidget {
  final Widget startWidget;

  GlobalApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GlobalCubit()
            ..getUserData()
            ..getPosts(context),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
