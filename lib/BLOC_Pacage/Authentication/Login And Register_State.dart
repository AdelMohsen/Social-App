abstract class LoginState {}

class LoginInitialState extends LoginState {}

class ShowPasswordState extends LoginState {}

//LoginStates
class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  var uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  late String error;

  LoginErrorState(this.error);
}

//RegisterationStates
class RegisterLoadingState extends LoginState {}

class RegisterSuccessState extends LoginState {}

class RegisterErrorState extends LoginState {
  late String error;

  RegisterErrorState(this.error);
}

class UserStoreSuccessState extends LoginState {
  final String uId;

  UserStoreSuccessState(this.uId);
}

class UserStoreErrorState extends LoginState {
  final String error;

  UserStoreErrorState(this.error);
}
