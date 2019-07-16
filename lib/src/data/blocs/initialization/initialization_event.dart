import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';

class InitializationEvent extends BlocEvent{

  final InitializationEventType type;

  InitializationEvent({
    this.type = InitializationEventType.start
  }) : assert(type != null);
}

enum InitializationEventType{
  start,
  initialized
}