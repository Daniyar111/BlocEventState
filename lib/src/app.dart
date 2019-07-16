import 'package:flutter/material.dart';

import 'data/blocs/authentication/authentication_bloc.dart';
import 'data/blocs/shopping_bloc/shopping_bloc.dart';
import 'data/providers/bloc_provider.dart';
import 'pages/initialization_page.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: BlocProvider<ShoppingBloc>(
        bloc: ShoppingBloc(),
        child: MaterialApp(
          title: 'BLoC',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/decision': (BuildContext context) => DecisionPage(),
            '/register': (BuildContext context) => RegistrationPage(),
            '/shoppingBasket': (BuildContext context) => ShoppingBasketPage()
          },
          home: InitializationPage(),
        ),
      ),
    );
  }
}
