import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Widgets/IconBroken.dart';
import 'package:social_app/Widgets/constant.dart';

class AddPostScreen extends StatelessWidget {
  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        var model = GlobalCubit.get(context).model;
        var postImage = GlobalCubit.get(context).postImage;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  cubit.changeBottomNav(0, context);
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            title: AutoSizeText(
              'Add Post',
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  if (postImage != null || postController.text != '') {
                    if (postImage == null) {
                      cubit.createPost(
                          dataTime: DateTime.now().toString(),
                          text: postController.text,
                          context: context);
                    } else {
                      cubit.uploadPostWithImage(
                          dataTime: DateTime.now().toString(),
                          text: postController.text,
                          context: context,
                          image: postImage);
                    }
                  }
                },
                child: AutoSizeText(
                  'POST',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [

                if (state is UploadPostLoadingState ||
                    state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('${model!.profileImage}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    AutoSizeText(
                      '${model.userName}',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 18,
                  keyboardType: TextInputType.text,
                  controller: postController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'What\'s in your mind ...?',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 20),
                    alignLabelWithHint: true,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                if (postImage != null)
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.file(postImage)
                                        .image, //Image.file(postImage!).image,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, top: 8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[300],
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      cubit.removePostImage(context);
                                    },
                                    icon: Icon(
                                      IconBroken.Delete,
                                      size: 20,
                                      color: MyColor.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          cubit.getPostImage(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AutoSizeText(
                              'add photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.blueAccent,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        child: AutoSizeText(
                          '# tags',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.blueAccent,
                                  ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
