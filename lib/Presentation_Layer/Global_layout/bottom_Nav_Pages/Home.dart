import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Presentation_Layer/Global_layout/add_post.dart';
import 'package:social_app/Widgets/IconBroken.dart';
import 'package:social_app/Widgets/Reuse_Widgets.dart';
import 'package:social_app/Widgets/constant.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_store_models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = GlobalCubit.get(context).model;
        var posts = GlobalCubit.get(context).posts;
        var cubit = GlobalCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => userModel != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      elevation: 5.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                              placeholder: 'assets/gif/loading.gif',
                              image:
                                  'https://www.sparkpost.com/wp-content/uploads/2019/02/dating-apps-email_800x300.jpg'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: AutoSizeText(
                              'communicate with your friends',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, AddPostScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                cubit.changeBottomNav(4, context);
                              },
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundImage: NetworkImage(
                                  '${userModel!.profileImage}',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: AutoSizeText(
                                "what's on your mind ?..",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 13.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(context, userModel, posts, index, cubit),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                    itemCount: posts.length,
                  ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => Center(
            child: Icon(IconBroken.Document),
          ),
        );
      },
    );
  }
}

buildPostItem(context, UsersModel? model, List<PostsModel> posts, int index,
        GlobalCubit cubit) =>
    Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, right: 16.0, top: 16.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage('${model!.profileImage}'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AutoSizeText(
                          '${model.userName}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 15,
                        ),
                      ],
                    ),
                    AutoSizeText(
                      '${posts[index].dataTime}',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(IconBroken.More_Circle))
              ],
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: AutoSizeText(
                '${posts[index].text}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(height: 1.2, fontWeight: FontWeight.w600),
              ),
            ),
            // Wrap(
            //   children: [
            //     Container(
            //       height: 25,
            //       child: MaterialButton(
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: AutoSizeText(
            //           '${posts[index]}',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //         minWidth: 1,
            //       ),
            //     ),
            //     Container(
            //       height: 25,
            //       child: MaterialButton(
            //         padding: EdgeInsets.zero,
            //         onPressed: () {},
            //         child: AutoSizeText(
            //           '#Dart ',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //         minWidth: 1,
            //       ),
            //     ),
            //   ],
            // ),
            if (posts[index].postImage != '')
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.zero,
                child: Image(
                  image: NetworkImage('${posts[index].postImage}'),
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          cubit.getLikes(cubit.postId[index]);
                        },
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: MyColor.red,
                              size: 22,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            AutoSizeText(
                              '${cubit.likes[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 13.5),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 5.0,
                      )),
                  Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.yellow,
                              size: 22,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            AutoSizeText(
                              '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 13.5),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            AutoSizeText(
                              'comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 13.5),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        cubit.changeBottomNav(4, context);
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          '${model.profileImage}',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {},
                      child: AutoSizeText(
                        'write a comment ...',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 13.5),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        cubit.getLikes(cubit.postId[index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: MyColor.red,
                            size: 22,
                          ),
                          AutoSizeText(
                            'Like',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
