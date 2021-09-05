import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_Cubit.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Widgets/IconBroken.dart';
import 'package:social_app/models/users_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  List<AllUsersModel> model;
  int index;

  ChatDetailsScreen(this.model, this.index);

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        cubit.getMessage(receiverId: model[index].uId);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 12.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${model[index].photo}'),
                  ),
                ),
                Text(
                  '${model[index].userName}',
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                    if(model[this.index].uId == cubit.messageList[index].senderId)
                        return buildSenderMessage(context,cubit.messageList[index]);
                   return buildMyMessage(context,cubit.messageList[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10.0,
                          ),
                      itemCount: cubit.messageList.length),
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'type your message..',
                              hintStyle: Theme.of(context).textTheme.caption),
                        ),
                      ),
                      MaterialButton(
                        height: 50.0,
                        color: Colors.lightBlueAccent,
                        minWidth: 1.0,
                        onPressed: () {
                          if(messageController.text != '') {
                            cubit.sendMessage(
                                dateTime: DateTime.now().toString(),
                                receiverId: model[index].uId,
                                text: messageController.text);
                            messageController.text = '';
                          }
                        },
                        child: Icon(
                          IconBroken.Send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  buildMyMessage(context,messageList) => Align(
        alignment: Alignment.centerRight,
        child: Container(
            padding: const EdgeInsets.all(12.0),
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                )),
            child: AutoSizeText(
              '${messageList.text}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            )),
      );

  buildSenderMessage(context,messageList) => Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: const EdgeInsets.all(12.0),
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                )),
            child: AutoSizeText(
              '${messageList.text}',
              style: Theme.of(context).textTheme.bodyText1,
            )),
      );
}
