part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  final AppUser? user = null;

  @override
  List<Object?> get props => throw UnimplementedError();
}
