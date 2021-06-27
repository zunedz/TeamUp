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

  final User? firebaseUser = FirebaseAuth.instance.currentUser;


@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();

  @override
  List<Object?> get props => [];
}

class AuthenticationLogged extends AuthenticationState {
  final AppUser user;
  const AuthenticationLogged(this.user);

  AuthenticationLogged.fromFirebaseUser(User? user) : this(user != null ? AppUser.fromFirebaseUser(user) : emptyUser);

  @override
  List<Object?> get props => [user];
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);

  @override
  List<Object?> get props => [message];
}
