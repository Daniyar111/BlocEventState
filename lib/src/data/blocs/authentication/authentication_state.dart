import '../../providers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class AuthenticationState extends BlocState{

  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;

  final String name;

  AuthenticationState({
    @required this.isAuthenticated,
    this.isAuthenticating = false,
    this.hasFailed = false,
    this.name = ''
  });

  factory AuthenticationState.notAuthenticated(){
    return AuthenticationState(
      isAuthenticated: false
    );
  }

  factory AuthenticationState.authenticated(String name){
    return AuthenticationState(
      isAuthenticated: true,
      name: name
    );
  }

  factory AuthenticationState.authenticating(){
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
    );
  }

  factory AuthenticationState.failed(){
    return AuthenticationState(
      isAuthenticated: false,
      hasFailed: true
    );
  }

}