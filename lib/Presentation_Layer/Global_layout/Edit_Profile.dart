import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Widgets/IconBroken.dart';
import 'package:social_app/Widgets/Reuse_Widgets.dart';
import 'package:social_app/Widgets/constant.dart';

class EditProfileScreen extends StatelessWidget {
  var userNameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
      listener: (context, state) {
        if (state is UpdateProfileImageSuccess)
          GlobalCubit.get(context).profileImage = null;
        if (state is UpdateCoverImageSuccess)
          GlobalCubit.get(context).coverImage = null;
      },
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        var model = GlobalCubit.get(context).model;
        var profileImage = GlobalCubit.get(context).profileImage;
        var coverImage = GlobalCubit.get(context).coverImage;
        userNameController.text = model!.userName;
        bioController.text = model.bio;
        phoneController.text = model.phone;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            title: AutoSizeText('Edit Profile'),
            actions: [
              MaterialButton(
                padding: EdgeInsets.zero,
                color: Theme.of(context).appBarTheme.backgroundColor,
                onPressed: () {
                  cubit.updateUserData(
                      userName: userNameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                      context: context);
                },
                child: AutoSizeText(
                  'UPDATE',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.blueAccent),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoading) LinearProgressIndicator(),
                  if (state is UpdateUserDataLoading)
                    SizedBox(
                      height: 15.0,
                    ),
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null
                                        ? NetworkImage('${model.coverImage}')
                                        : Image.file(coverImage).image,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, bottom: 8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[300],
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                      color: MyColor.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: 59.0,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 55.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${model.profileImage}')
                                    : Image.file(profileImage).image,
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey[300],
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                    color: MyColor.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                cubit.uploadProfileImage(
                                    userName: userNameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                    profileImage: profileImage,
                                    context: context);
                              },
                              child: Text(
                                'upload profile image',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        if (profileImage != null && coverImage != null)
                          SizedBox(
                            width: 10.0,
                          ),
                        if (coverImage != null)
                          Expanded(
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                cubit.uploadCoverImage(
                                    userName: userNameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                    context: context,
                                    coverImage: coverImage);
                              },
                              child: Text(
                                'upload cover image',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (profileImage != null || coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultTextFormField(
                      maxLength: 32,
                      keyBoardType: TextInputType.text,
                      labelText: 'USER NAME',
                      suffexIcon: Icon(IconBroken.User),
                      validator: (value) =>
                          value!.isEmpty ? 'USER NAME MUST NOT BE EMPTY' : null,
                      maxLines: 1,
                      controller: userNameController,
                      context: context),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                      maxLength: 128,
                      keyBoardType: TextInputType.text,
                      labelText: 'BIO',
                      suffexIcon: Icon(IconBroken.Info_Circle),
                      validator: (value) {},
                      maxLines: 2,
                      controller: bioController,
                      context: context),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                      maxLength: 11,
                      keyBoardType: TextInputType.phone,
                      labelText: 'PHONE',
                      suffexIcon: Icon(IconBroken.Call),
                      validator: (value) => value!.isEmpty
                          ? 'PHONE NUMBER MUST NOT BE EMPTY'
                          : null,
                      maxLines: 1,
                      controller: phoneController,
                      context: context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
