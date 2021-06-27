part of 'authentication_cubit.dart';

final AppUser emptyUser = AppUser(
    isInsideRoom: false,
    isOnline: false,
    pictureUrl: "",
    username: "",
    dateCreated: DateTime.now(),
    email: "",
    id: "",
  );

@immutable
abstract class AuthenticationState extends Equatable {
  AppUser? user = null;

  AuthenticationState();

  @override
  List<AppUser?> get props => [user];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLogged extends AuthenticationState {

  AuthenticationLogged.fromFirebaseUser(User? user) {
    this.user = user != null ? AppUser.fromFirebaseUser(user) : emptyUser;
  }
}
