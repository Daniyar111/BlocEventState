import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'bloc_event_state.dart';


// Base class used for the transformation of a state

abstract class BlocStateTransformBase<T, S extends BlocState> implements BlocBase{

  // Initial State
  final T initialState;

  // Transformed States
  BehaviorSubject<T> _stateController = BehaviorSubject<T>();
  Stream<T> get state => _stateController;

  // [Must override] state handler
  Stream<T> stateHandler({T currentState, S newState});

  // Constructor
  BlocStateTransformBase({
    @required this.initialState,
    @required BlocEventStateBase<BlocEvent, BlocState> blocIn
  }){
    assert(blocIn != null);
    assert(blocIn is BlocEventStateBase<BlocEvent, BlocState>);

    blocIn.state.listen((BlocState stateIn){
      T currentState = _stateController.value ?? initialState;

      stateHandler(currentState: currentState, newState: stateIn).forEach((T newState){
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose() {
    _stateController?.close();
  }

}