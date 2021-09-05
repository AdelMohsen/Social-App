import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/BLOC_Pacage/Global_Cubit/Global_States.dart';
import 'package:social_app/Presentation_Layer/Global_layout/bottom_Nav_Pages/Chats.dart';
import 'package:social_app/Presentation_Layer/Global_layout/bottom_Nav_Pages/Home.dart';
import 'package:social_app/Presentation_Layer/Global_layout/bottom_Nav_Pages/Settings.dart';
import 'package:social_app/Presentation_Layer/Global_layout/bottom_Nav_Pages/Users.dart';
import 'package:social_app/Widgets/IconBroken.dart';
import 'package:social_app/Widgets/constant.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_store_models.dart';
import 'package:social_app/models/users_model.dart';

class GlobalCubit extends Cubit<GlobalStates> {
  GlobalCubit() : super(GlobalInitialState());

  static GlobalCubit get(context) => BlocProvider.of(context);
  UsersModel? model;
  PostsModel? postsModel;
  AllUsersModel? allUsersModel;

  getUserData() {
    emit(GlobalGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UsersModel.fromJson(value.data()!);
      emit(GlobalGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GlobalGetUserErrorState(error.toString()));
    });
  }

//******************************************************************************
//BottomNavigationLogics
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<Widget> actions = [
    IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
    IconButton(onPressed: () {}, icon: Icon(IconBroken.Search))
  ];
  List<Widget> items = [
    Icon(IconBroken.Home),
    Icon(IconBroken.Chat),
    Icon(IconBroken.User),
    Icon(IconBroken.Setting),
  ];
  List<String> titles = ['GLOBAL', 'CHATS', 'USERS', 'SETTINGS'];

  changeBottomNav(int index, context) {
    currentIndex = index;
    if (currentIndex == 1) getAllUsers();
    emit(ChangeBottomNavState());
  }

//******************************************************************************
//IMAGE PICKER AND STORAGE
  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(PickedProfileImageSuccessState());
    } else {
      print('no image selected');
      emit(PickedProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(PickedCoverImageSuccessState());
    } else {
      print('no image selected');
      emit(PickedCoverImageErrorState());
    }
  }

  uploadProfileImage(
      {required userName,
      required phone,
      required bio,
      required context,
      profileImage,
      coverImage}) {
    emit(UpdateUserDataLoading());
    FirebaseStorage.instance
        .ref()
        .child(p.basename(profileImage!.path))
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          userName: userName,
          phone: phone,
          bio: bio,
          context: context,
          profileImage: value,
        );
        emit(UpdateProfileImageSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(UpdateUserDataError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataError());
    });
  }

  uploadCoverImage(
      {required userName,
      required phone,
      required bio,
      required context,
      profileImage,
      coverImage}) {
    emit(UpdateUserDataLoading());
    FirebaseStorage.instance
        .ref()
        .child(p.basename(coverImage!.path))
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          userName: userName,
          phone: phone,
          bio: bio,
          context: context,
          coverImage: value,
        );
        emit(UpdateCoverImageSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(UpdateUserDataError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataError());
    });
  }

  updateUser(
      {required userName,
      required phone,
      required bio,
      required context,
      profileImage,
      coverImage}) {
    UsersModel usersModel = UsersModel(
        userName: userName,
        email: model!.email,
        phone: phone,
        uId: uId,
        bio: bio,
        profileImage: profileImage ?? model!.profileImage,
        coverImage: coverImage ?? model!.coverImage,
        isEmailVerification: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(usersModel.toMap())
        .then((value) {
      getUserData();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('update successfully')));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataError());
    });
  }

  updateUserData({
    required userName,
    required phone,
    required bio,
    required context,
  }) {
    updateUser(
      userName: userName,
      phone: phone,
      bio: bio,
      context: context,
    );
  }

  //CREATE POST
  File? postImage;

  Future<void> getPostImage(context) async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PickedPostImageSuccessState());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('no image selected')));
      emit(PickedPostImageErrorState());
    }
  }

  removePostImage(context) {
    postImage = null;
    emit(RemovePostImageState());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('image remove successfully')));
  }

  uploadPostWithImage(
      {required dataTime, required text, required context, required image}) {
    emit(UploadPostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(p.basename(postImage!.path))
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dataTime: dataTime,
          text: text,
          postImage: value,
          context: context,
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('added successfully')));
        emit(UploadPostSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadPostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadPostErrorState());
    });
  }

  createPost({required dataTime, required text, postImage, required context}) {
    emit(CreatePostLoadingState());
    PostsModel postsModel = PostsModel(
      userName: model!.userName,
      uId: model!.uId,
      profileImage: model!.profileImage,
      dataTime: dataTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postsModel.toMap())
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('added successfully')));
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostsModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  getPosts(context) {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostsModel.fromJson(element.data()));
          emit(GetPostsSuccessState());
        }).catchError((error) {
          emit(GetPostsErrorState());
        });
      });
    }).catchError((error) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('${error.toString()}')));
      emit(GetPostsErrorState());
    });
  }

  List<AllUsersModel> users = [];

  getAllUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(AllUsersModel.fromJson(element.data()));
          emit(GetAllUserSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUserErrorState());
      });
    }
  }

  bool likeId = false;

  getLikes(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': !likeId}).then((value) {
      emit(GetLikeSuccessState());
    }).catchError((error) {
      emit(GetLikeErrorState());
    });
  }

  sendMessage({
    required dateTime,
    required receiverId,
    required text,
  }) {
    MessageModel messageModel = MessageModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: model!.uId,
        text: text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messageList = [];

  getMessage({required receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messageList = [];
      event.docs.forEach((element) {
        messageList.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }

//******************************************************************************

}
