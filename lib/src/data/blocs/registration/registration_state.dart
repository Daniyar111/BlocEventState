import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';

class RegistrationState extends BlocState{

  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;

  RegistrationState({
    this.isBusy = false,
    this.isSuccess = false,
    this.isFailure = false
  });

  factory RegistrationState.noAction(){
    return RegistrationState();
  }

  factory RegistrationState.busy(){
    return RegistrationState(
      isBusy: true
    );
  }

  factory RegistrationState.success(){
    return RegistrationState(
      isSuccess: true,
    );
  }

  factory RegistrationState.failure(){
    return RegistrationState(
      isFailure: true
    );
  }
}