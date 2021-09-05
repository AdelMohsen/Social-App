import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';

class GlobalLayout extends StatelessWidget {
  const GlobalLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GlobalCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: cubit.actions,
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              color: Colors.pinkAccent,
              height: 50.0,
              animationCurve: Curves.fastOutSlowIn,
              items: cubit.items,
              onTap: (index) {
                cubit.changeBottomNav(index, context);
              },
              index: cubit.currentIndex,
              letIndexChange: (index) => true,
            ),
            body: Conditional.single(
                context: context,
                conditionBuilder: (context) => state is! GetPostsLoadingState,
                widgetBuilder: (context) => cubit.screens[cubit.currentIndex],
                fallbackBuilder: (context) => Platform.isAndroid
                    ? Center(child: CircularProgressIndicator())
                    : Center(child: CupertinoActivityIndicator())),
          );
        });
  }
}
