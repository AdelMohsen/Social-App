import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Presentation_Layer/chat_details/chat_details_screen.dart';
import 'package:social_app/Widgets/Reuse_Widgets.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var users = GlobalCubit.get(context).users;
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        ChatDetailsScreen(users,index));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('${users[index].photo}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        AutoSizeText(
                          '${users[index].userName}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 14.0),
                  child: Container(
                    color: Colors.grey[300],
                    height: 2.0,
                  ),
                ),
            itemCount: users.length);
      },
    );
  }
}
