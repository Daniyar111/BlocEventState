import 'package:flutter/material.dart';

import '../providers/bloc_event_state.dart';
import '../providers/bloc_state_transform_base.dart';

typedef Widget AsyncBlocStateBuilder<BlocState>(BuildContext context, BlocState state);

class BlocStateTransformBuilder<T extends BlocState, S extends BlocState> extends StatelessWidget {

  final BlocStateTransformBase<T, S> transformBloc;
  final AsyncBlocStateBuilder<T> builder;

  const BlocStateTransformBuilder({
    Key key,
    @required this.transformBloc,
    @required this.builder
  }): assert(builder != null),
      assert(transformBloc != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: transformBloc.state,
      initialData: transformBloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot){
        return builder(context, snapshot.data);
      },
    );
  }
}
