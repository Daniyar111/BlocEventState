import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';

import 'initialization_event.dart';
import 'initialization_state.dart';

class InitializationBloc extends BlocEventStateBase<InitializationEvent, InitializationState>{

  InitializationBloc()
      : super(initialState: InitializationState.notInitialized());

  @override
  Stream<InitializationState> eventHandler(InitializationEvent event, InitializationState currentState) async* {

    if(!currentState.isInitialized){
      yield InitializationState.notInitialized();
    }

    if(event.type == InitializationEventType.start){
      for(int progress = 0; progress <= 100; progress += 10){
        await Future.delayed(Duration(milliseconds: 300));
        yield InitializationState.progressing(progress);
      }
    }

    if(event.type == InitializationEventType.initialized){
      yield InitializationState.initialized();
    }
  }
}