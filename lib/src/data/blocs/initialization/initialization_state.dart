import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class InitializationState extends BlocState{

  final bool isInitialized;
  final bool isInitializing;
  final int progress;

  InitializationState({
    @required this.isInitialized,
    this.isInitializing = false,
    this.progress = 0
  });

  factory InitializationState.notInitialized(){
    return InitializationState(
      isInitialized: false
    );
  }

  factory InitializationState.progressing(int progress){
    return InitializationState(
      isInitialized: false,
      isInitializing: true,
      progress: progress
    );
  }

  factory InitializationState.initialized(){
    return InitializationState(
      isInitialized: true,
      progress: 100
    );
  }
}