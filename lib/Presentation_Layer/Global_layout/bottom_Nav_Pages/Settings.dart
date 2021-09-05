import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Presentation_Layer/Global_layout/Edit_Profile.dart';
import 'package:social_app/Widgets/IconBroken.dart';
import 'package:social_app/Widgets/Reuse_Widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = GlobalCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 160.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${model!.coverImage}'),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 59.0,
                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundImage: NetworkImage('${model.profileImage}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              AutoSizeText(
                '${model.userName}',
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 25.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              AutoSizeText(
                '${model.bio}',
                maxLines: 3,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          AutoSizeText(
                            '100',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          AutoSizeText(
                            'post',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          AutoSizeText(
                            '250',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          AutoSizeText(
                            'photos',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          AutoSizeText(
                            '10k',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          AutoSizeText(
                            'followers',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          AutoSizeText(
                            '270',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          AutoSizeText(
                            'following',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('add photo'),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(IconBroken.Edit_Square),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
