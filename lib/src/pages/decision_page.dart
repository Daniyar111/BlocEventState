import 'package:authentication_bloc/src/data/bloc_widgets/bloc_state_builder.dart';
import 'package:authentication_bloc/src/data/blocs/authentication/authentication_bloc.dart';
import 'package:authentication_bloc/src/data/blocs/authentication/authentication_state.dart';
import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'authentication_page.dart';
import 'home_page.dart';

class DecisionPage extends StatefulWidget {

  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {

  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {

    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocEventStateBuilder(
      bloc: bloc,
      builder: (BuildContext context, AuthenticationState state){
        if(state != oldAuthenticationState){
          oldAuthenticationState = state;

          if(state.isAuthenticated){
            _redirectToPage(context, HomePage());
          }
          else if(state.isAuthenticating || state.hasFailed){
            // do nothing
          }
          else{
            _redirectToPage(context, AuthenticationPage());
          }
        }
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
