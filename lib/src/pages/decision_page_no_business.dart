import 'package:authentication_bloc/src/data/bloc_widgets/bloc_state_transform_builder.dart';
import 'package:authentication_bloc/src/data/blocs/authentication/authentication_bloc.dart';
import 'package:authentication_bloc/src/data/blocs/authentication/authentication_state.dart';
import 'package:authentication_bloc/src/data/blocs/decision/decision_state_transform.dart';
import 'package:authentication_bloc/src/data/blocs/decision/decistion_state_action.dart';
import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:flutter/material.dart';


/// Version of the DecisionPage which does not
/// contain any business logic related to the
/// action to take, based on the authentication
/// status.
///
/// This page uses the [BlocStateTransformBase]
/// to apply the Business Logic and the
/// [BlocStateTransformBuilder] to be notified
/// of the action to take.
///
/// The [DecisionStateTransform] is the place where
/// all the Business Logic resides.

class DecisionPageNoBusiness extends StatefulWidget {

  @override
  _DecisionPageNoBusinessState createState() => _DecisionPageNoBusinessState();
}

class _DecisionPageNoBusinessState extends State<DecisionPageNoBusiness> {

  DecisionStateTransform decisionStateTransform;
  DecisionStateAction oldAction;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialization of the State Transform related to the DecisionPage

    decisionStateTransform = DecisionStateTransform.init(BlocProvider.of<AuthenticationBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocStateTransformBuilder<DecisionStateAction, AuthenticationState>(
      transformBloc: decisionStateTransform,
      builder: (BuildContext context, DecisionStateAction action){
        if(action != oldAction){

          // As this page is used to route to other pages, once another page is displayed,
          // this page will be rebuilt. Therefore, we need to prevent from bubbling

          oldAction = action;

          if(action.actionType == DecisionStateActionType.routeToPage){
            _redirectToPage(context, action.newPage);
          }
        }

        // This page does not need to display anything since it will always remain behind any active page (and thus 'hidden')
        return Container();
      },
    );
  }


  void _redirectToPage(BuildContext context, Widget page){

    WidgetsBinding.instance.addPostFrameCallback((_){
      MaterialPageRoute newRoute = MaterialPageRoute(
          builder: (BuildContext context) => page
      );

      Navigator.of(context).pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}
