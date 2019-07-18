import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';

class RegistrationEvent extends BlocEvent {

  final RegistrationEventType event;
  final String email;
  final String password;

  RegistrationEvent({
    this.event,
    this.email,
    this.password
  });
}

enum RegistrationEventType{
  none,
  working
}