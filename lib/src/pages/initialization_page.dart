import 'package:authentication_bloc/src/data/bloc_widgets/bloc_state_builder.dart';
import 'package:authentication_bloc/src/data/blocs/initialization/initialization_bloc.dart';
import 'package:authentication_bloc/src/data/blocs/initialization/initialization_event.dart';
import 'package:authentication_bloc/src/data/blocs/initialization/initialization_state.dart';
import 'package:flutter/material.dart';

class InitializationPage extends StatefulWidget {

  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {

  InitializationBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = InitializationBloc();
    bloc.emitEvent(InitializationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocEventStateBuilder<InitializationState>(
              bloc: bloc,
              builder: (BuildContext context, InitializationState state){
                if(state.isInitialized){
                  print('initialized');

                  // Once the initialization is completed, let's move to another page
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.of(context).pushReplacementNamed('/decision');
                  });
                }
                return Text('Initialization in progress ... ${state.progress}');
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }
}
