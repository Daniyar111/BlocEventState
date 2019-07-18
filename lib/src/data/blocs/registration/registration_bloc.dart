import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';

import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends BlocEventStateBase<RegistrationEvent, RegistrationState>{

  RegistrationBloc()
      : super(
          initialState: RegistrationState.noAction()
        );

  @override
  Stream<RegistrationState> eventHandler(RegistrationEvent event, RegistrationState currentState) async* {

    if(event.event == RegistrationEventType.working){
      yield RegistrationState.busy();

      print('Registration of ${event.email}/${event.password}');

      await Future.delayed(Duration(seconds: 1));

      yield RegistrationState.success();
    }
  }

}