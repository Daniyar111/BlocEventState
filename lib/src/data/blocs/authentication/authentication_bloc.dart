import '../../providers/bloc_event_state.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends BlocEventStateBase<AuthenticationEvent, AuthenticationState>{

  AuthenticationBloc()
      : super(initialState: AuthenticationState.notAuthenticated());

  @override
  Stream<AuthenticationState> eventHandler(AuthenticationEvent event, AuthenticationState currentState) async* {

    if(event is AuthenticationEventLogin){

      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      // Simulate a call to the authentication server
      await Future.delayed(Duration(seconds: 2));

      // Inform that we have successfully authenticated, or not
      if(event.name == 'failure'){
        yield AuthenticationState.failed();
      }
      else{
        yield AuthenticationState.authenticated(event.name);
      }
    }

    if(event is AuthenticationEventLogout){
      yield AuthenticationState.notAuthenticated();
    }
  }

}