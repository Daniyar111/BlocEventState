import 'package:flutter/material.dart';

import '../providers/bloc_event_state.dart';

typedef Widget AsyncBlocStateBuilder<BlocState>(BuildContext context, BlocState state);

class BlocEventStateBuilder extends StatelessWidget {

  final BlocEventStateBase<BlocEvent, BlocState> bloc;
  final AsyncBlocStateBuilder<BlocState> builder;

  const BlocEventStateBuilder({
    Key key,
    @required this.bloc,
    @required this.builder
  }): assert(builder != null),
      assert(bloc != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot){
        return builder(context, snapshot.data);
      },
    );
  }
}
