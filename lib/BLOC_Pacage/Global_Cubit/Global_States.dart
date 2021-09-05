abstract class GlobalStates {}

class GlobalInitialState extends GlobalStates {}

class GlobalGetUserLoadingState extends GlobalStates {}

class GlobalGetUserSuccessState extends GlobalStates {}

class GlobalGetUserErrorState extends GlobalStates {
  final String error;

  GlobalGetUserErrorState(this.error);
}

class ChangeBottomNavState extends GlobalStates {}

class PickedProfileImageSuccessState extends GlobalStates {}

class PickedProfileImageErrorState extends GlobalStates {}

class PickedCoverImageSuccessState extends GlobalStates {}

class PickedCoverImageErrorState extends GlobalStates {}

class UpdateUserDataLoading extends GlobalStates {}

class UpdateUserDataSuccess extends GlobalStates {}

class UpdateUserDataError extends GlobalStates {}

class UpdateCoverImageSuccess extends GlobalStates {}

class UpdateProfileImageSuccess extends GlobalStates {}

//CREATE POST

class PickedPostImageSuccessState extends GlobalStates {}

class PickedPostImageErrorState extends GlobalStates {}

class RemovePostImageState extends GlobalStates {}

class UploadPostLoadingState extends GlobalStates {}

class UploadPostSuccessState extends GlobalStates {}

class UploadPostErrorState extends GlobalStates {}

class CreatePostLoadingState extends GlobalStates {}

class CreatePostSuccessState extends GlobalStates {}

class CreatePostErrorState extends GlobalStates {}

//GET POSTS
class GetPostsLoadingState extends GlobalStates {}

class GetPostsSuccessState extends GlobalStates {}

class GetPostsErrorState extends GlobalStates {}

//LIKES
class GetLikeSuccessState extends GlobalStates {}

class GetLikeErrorState extends GlobalStates {}

//get all user
class GetAllUserSuccessState extends GlobalStates {}

class GetAllUserErrorState extends GlobalStates {}

//send message
class SendMessageSuccessState extends GlobalStates {}

class SendMessageErrorState extends GlobalStates {}

//get Message
class GetMessageSuccessState extends GlobalStates {}



